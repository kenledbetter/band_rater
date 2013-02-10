class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def check_permission(user, options = {})
    if !current_user
      return false
    elsif current_user && current_user.admin
      return true
    elsif (current_user == user) && !options[:admin_required]
      return true
    else
      return false
    end
  end

  helper_method :current_user
  helper_method :check_permission
end
