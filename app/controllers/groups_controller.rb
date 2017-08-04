class GroupsController < ApplicationController
  before_action :set_group, only: [:edit, :update, :destroy]

  def index
    @groups = current_user.groups
  end

  def show
    @group = Group.includes(:users, meals: :ratings)
                  .find(params[:id])
    users = @group.users
    users.each do |user|
      if @u = GroupsUser.find_by(group_id: @group.id, user_id: user.id)
        user.role = @u.role
      end
    end

    @users = users.sort_by(&:role)
    @meal = Meal.new
    @meals = @group.meals.order(:meal_date)
    @average = MetricsService.new(@meals.to_a).meals_average
  end

  def new
    @group = Group.new
  end

  def edit
  end

  def create
    @group = Group.new(group_params)

    if @group.save
      if GroupsUser.create(user_id: current_user.id, group_id: @group.id, role: "Admin")
        flash[:success] = "Creation Success for: Group"
        redirect_to @group
      end
    else
      render 'new'
    end
  end

  def update
    if @group.update(group_params)
      flash[:success] = "Update Success for: Group"
      redirect_to @group
    else
      render 'edit'
    end
  end

  def destroy
    @group.destroy

    redirect_to root_url
  end

  def AddUserToGroup
    @user = User.find_by(email: params[:email]);
    @group = Group.find(params[:groupId])

    if !@user.nil? && !@group.nil?
      if !@group.user_ids.include?(@user.id)
        if GroupsUser.create(user_id: @user.id, group_id: @group.id, role: "Standard")
          flash[:success] = "User added to group!"
          redirect_to @group
        end
      else
        flash[:danger] = "User already in group"
        redirect_to @group
      end
    else
      flash[:warning] = "User not found"
      redirect_to @group
    end
  end

  def DeleteUserFromGroup
    @user = User.find(params[:userId])
    @group = Group.find(params[:groupId])

    if !@user.nil? && !@group.nil?
      if @group.users.include?(@user)
        @user.groups.delete(@group)
        flash[:success] = "User removed from group"
        redirect_to @group
      else
        flash[:danger] = "User is already not in this group"
        redirect_to @group
      end
    else
      flash[:warning] = "Cannot find user"
      redirect_to @group
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name)
    end
end
