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
        redirect_to bands_path, :notice => "Band does not exist"
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
          redirect_to @band, :notice => "Band updated"
        else
          render "edit"
        end
      else
        redirect_to bands_path, :notice => "Band does not exist"
      end
    else
      redirect_to bands_path, :notice => "Must be a reviewer to modify a band"
    end
  end

  def index
    @bands = Band.find(:all)
    respond_to do |format|
      format.html
      format.json {render json: @bands }
    end
  end

  def show
    # Get band and prefetch ratings
    if @band = Band.includes(:ratings, :festivals).find_by_id(params[:id])
      @ratings = @band.ratings
      @festivals = @band.festivals
  
      # Get rating from current user if logged in
      if current_user
        @rating = Rating.where(
          :band_id => @band, :user_id => current_user).first
  
        if @rating.nil?
          @rating = Rating.new
        end
      end
    else
      redirect_to bands_path, :notice => "Band does not exist"
    end
  end

  def destroy
    # Only allowed logged in reviewers to modify bands
    if current_user && current_user.is_reviewer?
      if @band = Band.find_by_id(params[:id])
        if @band.destroy
          redirect_to bands_path, :notice => "Band deleted"
        else
          render "show"
        end
      else
        redirect_to @band, :notice => "Band does not exist"
      end
    else
      redirect_to bands_path, :notice => "Must be a reviewer to modify a band"
    end
  end

  def import
    # Only allow admins to import yaml
    if current_user && current_user.is_admin?
      if request.post? && params[:file].present?
        yaml = YAML::load(params[:file].read)

        yaml.each do |row|
          if band = Band.find_or_create_by_name(row[:name])
            band.update_attributes(row)
          end
        end

        redirect_to import_bands_path, :notice => "File uploaded"
      else
        render "import"
      end
    else
      redirect_to bands_path, :notice => "Must be an admin to import files"
    end
  end

  def export
    # Only allow admins to export yaml
    if current_user && current_user.is_admin?
      bands = Band.all

      attributes = []

      bands.each do |band|
        a = band.attributes
        a.delete("created_at")
        a.delete("updated_at")
        attributes.push(a)
      end

      send_data attributes.to_yaml,
        :filename => "bands.yaml",
        :type => "text/yaml"
    else
      redirect_to bands_path, :notice => "Must be an admin to import files"
    end
  end
end
