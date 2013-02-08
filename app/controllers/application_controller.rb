class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def check_permission(options = {})
    if current_user && current_user.admin
      return true
    elsif !options[:user].nil? && current_user == options[:user] && !options[:admin]
      return true
    else
      return false
    end
  end

  helper_method :current_user
  helper_method :check_permission
end
