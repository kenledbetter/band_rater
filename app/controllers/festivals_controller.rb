class FestivalsController < ApplicationController
  def new
    # Only allowed logged in reviewers to create festivals
    if current_user && current_user.is_reviewer?
      @festival = Festival.new
    else
      redirect_to festivals_path, :notice => "Must be a reviewer to create a festival"
    end
  end

  def create
    # Only allowed logged in reviewers to create festivals
    if current_user && current_user.is_reviewer?
      @festival = Festival.new(params[:festival])
  
      if @festival.save
        redirect_to @festival, :notice => "Festival created"
      else
        render "new"
      end
    else
      redirect_to festivals_path, :notice => "Must be a reviewer to create a festival"
    end
  end

  def edit
    # Only allowed logged in reviewers to modify festivals
    if current_user && current_user.is_reviewer?
      if @festival = Festival.find_by_id(params[:id])
        render "edit"
      else
        redirect_to @festival, :notice => "Festival does not exist"
      end
    else
      redirect_to festivals_path, :notice => "Must be a reviewer to modify a festival"
    end
  end

  def update
    # Only allowed logged in reviewers to modify festivals
    if current_user && current_user.is_reviewer?
      if @festival = Festival.find_by_id(params[:id])
        if @festival.update_attributes(params[:festival])
          redirect_to @festival, :notice => "Festival updated"
        else
          render "edit"
        end
      else
        redirect_to @festival, :notice => "Festival does not exist"
      end
    else
      redirect_to festivals_path, :notice => "Must be a reviewer to modify a festival"
    end
  end

  def index
    @festivals = Festival.order('date asc').find(:all)
  end

  def show
    @festival = Festival.includes(:bands).find(params[:id])
    @bands = @festival.bands
  end
end
