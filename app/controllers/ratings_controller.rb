class RatingsController < ApplicationController
  def new
    @rating = Rating.new
  end

  def create
    @rating = Rating.new(params[:rating])
    @rating.user = current_user

    if @rating.save
      redirect_to @rating.band, :notice => "Rating created"
    else
      render "new"
    end
  end
end
