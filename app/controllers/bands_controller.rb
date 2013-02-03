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

  def index
    @bands = Band.find(:all)
  end

  def show
    @band = Band.find(params[:id], :include => :ratings)
    ratings = @band.ratings.map{|rating| rating.rating}
    @average_rating = ratings.inject(0.0) {|sum, rating| sum + rating}/ratings.size
  end
end
