class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    role = current_user.nil? ? :default : current_user.role

    @user = User.new(params[:user], :as => role)
    if @user.save
      redirect_to root_url, :notice => "Signed up!"
    else
      render "new"
    end
  end

  def edit
    if @user = User.find_by_id(params[:id])
      if check_permission(@user)
        render "edit"
      else
        redirect_to @user, :notice => "Cannot edit another user's profile" 
      end
    else
      redirect_to users_path, :notice => "User does not exist"
    end
  end

  def update
    if @user = User.find_by_id(params[:id])
      # Only attempt to update password if not blank
      if params[:password_confirmation].blank? 
        params.delete(:password_confirmation) 
        params.delete(:password) if params[:password].blank? 
      end 
  
      if !check_permission(@user)
        redirect_to @user, :notice => "Cannot edit another user's profile" 
      elsif @user.update_attributes(params[:user], :as => current_user.role)
        redirect_to users_path, :notice => "User updated"
      else
        render "edit"
      end
    else
      redirect_to users_path, :notice => "User does not exist"
    end
  end

  def index
    @users = User.find(:all)
  end

  def show
    if @user = User.includes(:ratings).find_by_id(params[:id])
      @ratings = @user.ratings
    else
      redirect_to users_path, :notice => "User does not exist"
    end
  end

  def import
    # Only allow admins to import yaml
    if current_user && current_user.is_admin?
      if request.post? && params[:file].present?
        yaml = YAML::load(params[:file].read)

        yaml.each do |row|
          user = User.find_or_initialize_by_name(row[:name])

          if user.new_record? 
            user.save(:validate => false)
          else
            user.update_attributes(row)
          end
        end

        redirect_to import_users_path, :notice => "File uploaded"
      else
        render "import"
      end
    else
      redirect_to users_path, :notice => "Must be an admin to import files"
    end
  end
end
