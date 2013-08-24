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
    #@bands = @festival.bands
    @bands = @festival.bands.order("average_rating desc")
  end

  def export
    # Only allow admins to export yaml
    if current_user && current_user.is_admin?
      @festival = Festival.includes(:bands).find(params[:id])
      @bands = @festival.bands.order("average_rating desc")
      attributes = []

      @bands.each do |band|
        a = band.attributes
        a.delete("created_at")
        a.delete("updated_at")
        attributes.push(a)
      end

      send_data attributes.to_yaml,
        :filename => "#{@festival.name}.yaml",
        :type => "text/yaml"
    else
      redirect_to bands_path, :notice => "Must be an admin to import files"
    end
  end
end
