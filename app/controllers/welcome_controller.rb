class WelcomeController < ApplicationController
  skip_before_action :require_login, only: [:index, :welcome]

  def index
    unless logged_in?
      redirect_to welcome_path
      return
    end

    unless GroupsUser.exists?(user_id: current_user.id)
      flash[:info] = 'You are not part of a group yet, please create one to get started!'
      redirect_to new_group_path
      return
    end

    @user = User.find(session[:user_id])
  end
end
