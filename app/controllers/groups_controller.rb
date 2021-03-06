class GroupsController < ApplicationController
  before_action :set_group, only: [:edit, :update, :destroy]

  def show
    @group = Group.includes(:users, meals: :ratings)
                  .find(params[:id])
    @users = @group.users
                   .order('groups_users.role DESC')
                   .each { |u| u.role = u.groups_users.find_by(group: @group).role }
    @meal = Meal.new
    @meals = @group.meals.order(:meal_date)
    @average = MetricsService.new(@meals).meals_average
  end

  def new
    @group = Group.new
  end

  def edit; end

  def create
    @group = Group.new(group_params)

    if @group.save
      if GroupsUser.create(user_id: current_user.id, group_id: @group.id, role: 'Admin')
        flash[:success] = 'Creation Success for: Group'
        redirect_to @group
      end
    else
      render 'new'
    end
  end

  def update
    if @group.update(group_params)
      flash[:success] = 'Update Success for: Group'
      redirect_to @group
    else
      render 'edit'
    end
  end

  def destroy
    @group.destroy

    redirect_to root_url
  end

  def add_user_to_group
    @user = User.find_by(email: params[:email])
    @group = Group.find(params[:groupId])

    if !@user.nil? && !@group.nil?
      if !@group.user_ids.include?(@user.id)
        if GroupsUser.create(user_id: @user.id, group_id: @group.id, role: 'Standard')
          flash[:success] = 'User added to group!'
          redirect_to @group
        end
      else
        flash[:danger] = 'User already in group'
        redirect_to @group
      end
    else
      flash[:warning] = 'User not found'
      redirect_to @group
    end
  end

  def delete_user_from_group
    @user = User.find(params[:userId])
    @group = Group.find(params[:groupId])

    if !@user.nil? && !@group.nil?
      if @group.users.include?(@user)
        @user.groups.delete(@group)
        flash[:success] = 'User removed from group'
      else
        flash[:danger] = 'User is already not in this group'
      end
    else
      flash[:warning] = 'Cannot find user'
    end
    redirect_to @group
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
