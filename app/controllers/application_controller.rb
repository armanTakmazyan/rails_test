class ApplicationController < ActionController::Base

  before_action :set_no_cache

  def index
    
  end

protected  
  def set_no_cache
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

private
  
  def must_be_not_authenticated
    unless session[:user_id].nil?
        redirect_to companies_path
    end
  end

  def is_authenticated?
    session[:user_id].present?
  end

  helper_method :is_authenticated?

  def require_signin
    unless current_user
      session[:intended_url] = request.url
      redirect_to login_path, alert: "Please sign in first!"
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  helper_method :current_user

  def current_user?(user)
    current_user == user
  end

  helper_method :current_user?

  def require_admin
    unless current_user_admin?
      redirect_to login_path, alert: "Unauthorized access!"
    end
  end

  def current_user_admin?  
    current_user && current_user.admin?
  end

  helper_method :current_user_admin?
end
