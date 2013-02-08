class RatingsController < ApplicationController
  def new
    # Only allow logged in users to create ratings
    if current_user
      # Search for existing rating for user/band combo and redirect to edit
      if @rating = Rating.find_by_band_id_and_user_id(
        params[:band_id], current_user.id)
        redirect_to :action => 'edit', :id => @rating.id
      # Else create a new rating with the band id
      else
        @rating = Rating.new(:band_id => params[:band_id])
      end
    else
      redirect_to root_url, :notice => "Must be logged in to create a rating"
    end
  end

  def create
    # Only allow logged in users to create ratings
    if current_user
      @rating = Rating.new(params[:rating])
      @rating.user = current_user
  
      if @rating.save
        redirect_to @rating.band, :notice => "Rating created"
      else
        render 'new'
      end
    else
      redirect_to root_url, :notice => "Must be logged in to create a rating"
    end
  end

  def edit
    @rating = Rating.find(params[:id])

    redirect_to @rating.band
  end

  def update
    @rating = Rating.find(params[:id])

    # Only allow matching logged in user to modify rating
    if current_user && (@rating.user == current_user)
      if @rating.update_attributes(params[:rating])
        redirect_to @rating.band, :notice => "Rating updated"
      else
        redirect_to @rating.band
      end
    else
      redirect_to root_url, :notice =>
      "Only #{@rating.user.name} can modify this rating"
    end
  end

  def destroy
    @rating = Rating.find(params[:id])
    band = @rating.band

    # Only allow matching logged in user to modify rating
    if current_user && (@rating.user == current_user)
      if @rating.destroy
        redirect_to band, :notice => "Rating deleted"
      else
        redirect_to @rating.band
      end
    else
      redirect_to root_url, :notice =>
      "Only #{@rating.user.name} can modify this rating"
    end
  end

  def index
    @ratings = Rating.order("updated_at desc").find(:all)
  end

  def show
    @rating = Rating.includes(:band).find(params[:id])
    
    redirect_to @rating.band
  end
end
