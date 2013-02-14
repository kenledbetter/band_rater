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
end
