class RedirectsController < ApplicationController
  def new
    # Only allowed logged in admins to create redirects
    if current_user && current_user.is_admin?
      @redirect = Redirect.new
    # Silently redirect to root
    else
      redirect_to root_url
    end
  end

  def create
    # Only allowed logged in admins to create redirects
    if current_user && current_user.is_admin?
      @redirect = Redirect.new(params[:redirect])
  
      if @redirect.save
        redirect_to @redirect, :notice => "Redirect created"
      else
        render "new"
      end
    # Silently redirect to root
    else
      redirect_to root_url
    end
  end

  def edit
    # Only allowed logged in admins to modify redirects
    if current_user && current_user.is_admin?
      if !(@redirect = Redirect.find_by_id(params[:id]))
        redirect_to redirects_path, :notice => "Redirect does not exist"
      end
    # Silently redirect to root
    else
      redirect_to root_url
    end
  end

  def update
    # Only allowed logged in admins to modify redirects
    if current_user && current_user.is_admin?
      if @redirect = Redirect.find_by_id(params[:id])
        if @redirect.update_attributes(params[:redirect])
          redirect_to @redirect, :notice => "Redirect updated"
        else
          render "edit"
        end
      else
        redirect_to redirects_path, :notice => "Redirect does not exist"
      end
    # Silently redirect to root
    else
      redirect_to root_url
    end
  end

  def show
    # Only allowed logged in admins to view redirects
    if current_user && current_user.is_admin?
      if !(@redirect = Redirect.find_by_id(params[:id]))
        redirect_to redirects_path, :notice => "Redirect does not exist"
      end
    # Silently redirect to root
    else
      redirect_to root_url
    end
  end

  def index
    # Only allowed logged in admins to view redirects
    if current_user && current_user.is_admin?
      @redirects = Redirect.all
    # Silently redirect to root
    else
      redirect_to root_url
    end
  end

  def destroy
    # Only allowed logged in admins to modify redirects
    if current_user && current_user.is_admin?
      if @redirect = Redirect.find_by_id(params[:id])
        if @redirect.destroy
          redirect_to redirects_path, :notice => "Redirect deleted"
        else
          render "show"
        end
      else
        redirect_to @redirect, :notice => "Redirect does not exist"
      end
    # Silently redirect to root
    else
      redirect_to root_url
    end
  end

  def redirect
    if @redirect = Redirect.find_by_source(params[:url])
      redirect_to "/#{@redirect.destination}"
    else
      redirect_to root_url
    end
  end
end
