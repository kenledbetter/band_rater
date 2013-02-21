class LineupsController < ApplicationController
  def create
    # Only allowed logged in reviewers to create lineups
    if current_user && current_user.is_reviewer?
      @lineup = Lineup.new(params[:lineup])
  
      if @lineup.save
        redirect_to @lineup.band, :notice => "Lineup created"
      else
        render "new"
      end
    else
      redirect_to lineups_path, :notice => "Must be a reviewer to create a lineup"
    end
  end

  def import
    # Only allow admins to import yaml
    if current_user && current_user.is_admin?
      if request.post? && params[:file].present?
        yaml = YAML::load(params[:file].read)

        yaml.each do |row|
          if (band = Band.find_by_name(row[:band])) &&
            (festival = Festival.find_by_name(row[:festival]))
            if lineup = Rating.find_or_create_by_band_id_and_festival_id(band.id, festival.id)
              lineup.lineup = row[:lineup]
              lineup.save
            end
          end
        end

        redirect_to import_lineups_path, :notice => "File uploaded"
      else
        render "import"
      end
    else
      redirect_to lineups_path, :notice => "Must be an admin to import files"
    end
  end
end
