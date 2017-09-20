class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :dev_only, only: [:index]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in @user
      flash[:success] = 'Welcome to lunch! Where your freshman 15 is born.'
      redirect_to @user
    else
      render 'new'
    end
  end

  def default_group
    unless current_user.update_attribute(:default_group, Group.find(params[:default_group_id]))
      flash[:danger] = 'Failed to change default group'
    end
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end
end
