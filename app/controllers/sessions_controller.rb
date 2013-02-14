class SessionsController < ApplicationController
  def new
    session[:return_to] = request.referer
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to session[:return_to], :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to request.referer, :notice => "Logged out!"
  end
  
end
