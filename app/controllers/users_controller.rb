class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_url, :notice => "Signed up!"
    else
      render "new"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    # Only attempt to update email if not blank
    if params[:email_confirmation].blank? 
      params.delete(:email_confirmation) 
      params.delete(:email) if params[:email].blank? 
    end 

    # Only attempt to update password if not blank
    if params[:password_confirmation].blank? 
      params.delete(:password_confirmation) 
      params.delete(:password) if params[:password].blank? 
    end 

    if current_user.id != @user.id
      redirect_to @user, :notice => "Cannot edit another user's profile" 
    elsif @user.update_attributes(params[:user])
      redirect_to users_path, :notice => "User updated"
    else
      render "edit"
    end
  end

  def index
    @users = User.find(:all)
  end

  def show
    @user = User.includes(:ratings).find(params[:id])
    @ratings = @user.ratings
  end
end
