class BandsController < ApplicationController
  def new
    # Only allowed logged in reviewers to create bands
    if current_user && current_user.is_reviewer?
      @band = Band.new
    else
      redirect_to bands_path, :notice => "Must be a reviewer to create a band"
    end
  end

  def create
    # Only allowed logged in reviewers to create bands
    if current_user && current_user.is_reviewer?
      @band = Band.new(params[:band])
  
      if @band.save
        redirect_to @band, :notice => "Band created"
      else
        render "new"
      end
    else
      redirect_to bands_path, :notice => "Must be a reviewer to create a band"
    end
  end

  def edit
    # Only allowed logged in reviewers to modify bands
    if current_user && current_user.is_reviewer?
      if @band = Band.find_by_id(params[:id])
        render "edit"
      else
        redirect_to @band, :notice => "Band does not exist"
      end
    else
      redirect_to bands_path, :notice => "Must be a reviewer to modify a band"
    end
  end

  def update
    # Only allowed logged in reviewers to modify bands
    if current_user && current_user.is_reviewer?
      if @band = Band.find_by_id(params[:id])
        if @band.update_attributes(params[:band])
          redirect_to bands_path, :notice => "Band updated"
        else
          render "edit"
        end
      else
        redirect_to @band, :notice => "Band does not exist"
      end
    else
      redirect_to bands_path, :notice => "Must be a reviewer to modify a band"
    end
  end

  def index
    @bands = Band.order("average_rating desc").find(:all)
  end

  def show
    # Get band and prefetch ratings
    if @band = Band.includes(:ratings).find_by_id(params[:id])
      @ratings = @band.ratings
  
      # Get rating from current user if logged in
      if current_user
        @rating = Rating.where(
          :band_id => @band, :user_id => current_user).first
  
        if @rating.nil?
          @rating = Rating.new
        end
      end
    else
      redirect_to bands_path, :notice => "Must be a reviewer to create a band"
    end
  end
end
