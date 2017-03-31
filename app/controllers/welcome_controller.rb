class WelcomeController < ApplicationController
  skip_before_action :require_login, only: [:index]

  def index
    if logged_in?
      @user = User.find(session[:user_id])
    end
  end
end
