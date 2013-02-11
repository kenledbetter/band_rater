class IndexController < ApplicationController
  def index
    festival_id = Setting.index
    flash.keep

    if @festival = Festival.find_by_id(festival_id)
      redirect_to @festival
    else
      redirect_to festivals_path
    end
  end
end
