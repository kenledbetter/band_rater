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

  def index
    @festivals = Festival.find(:all)
  end

  def show
    @festival = Festival.find(params[:id])
    @bands = Band.where(:festival => @festival)
  end
end
