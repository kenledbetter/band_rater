class FestivalsController < ApplicationController
  def new
    @festival = Festival.new
  end

  def create
    @festival = Festival.new(params[:festival])

    if @festival.save
      redirect_to festivals_path, :notice => "Festival created"
    else
      render "new"
    end
  end

  def edit
    @festival = Festival.find(params[:id])
  end

  def update
    @festival = Festival.find(params[:id])

    # Only allow admin to modify festivals
    if check_permission(:admin => true)
      if @festival.update_attributes(params[:festival])
        redirect_to @festival, :notice => "Festival updated"
      else
        redirect_to @festival
      end
    else
      redirect_to root_url, :notice =>
      "Only admins can modify festivals"
    end
  end

  def index
    @festivals = Festival.order('date asc').find(:all)
  end

  def show
    @festival = Festival.includes(:bands).find(params[:id])
    @bands = Band
      .order("average_rating desc")
      .all(
        :joins => :festivals,
        :conditions => {:festivals => {:id => @festival.id}}
      )
  end
end
