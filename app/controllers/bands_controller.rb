class BandsController < ApplicationController
  def new
    @band = Band.new
  end

  def create
    @band = Band.new(params[:band])

    if @band.save
      redirect_to bands_path, :notice => "Band created"
    else
      render "new"
    end
  end

  def edit
    @band = Band.find(params[:id])
  end

  def update
    @band = Band.find(params[:id])

    if @band.update_attributes(params[:band])
      redirect_to bands_path, :notice => "Band updated"
    else
      render "edit"
    end
  end

  def index
    @bands = Band.order("average_rating desc").find(:all)
  end

  def show
    # Get band and prefetch ratings
    @band = Band.find(params[:id], :include => :ratings)
    @ratings = @band.ratings

    # Get rating from current user if logged in
    if current_user
      @rating = Rating.where(
        :band_id => @band, :user_id => current_user).first

      if @rating.nil?
        @rating = Rating.new
      end
    end
  end
end
