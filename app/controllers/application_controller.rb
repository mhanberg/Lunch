class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  before_action :require_login

  def require_login
    unless logged_in?
      flash[:danger] = "You must be logged in to access this section"
      redirect_to login_path
    end
  end
end
