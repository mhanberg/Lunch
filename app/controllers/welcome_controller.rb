class WelcomeController < ApplicationController
  skip_before_action :require_login, only: %i[index welcome]

  def index
    unless logged_in?
      redirect_to welcome_path
      return
    end

    @user = User.find(session[:user_id])
  end
end
