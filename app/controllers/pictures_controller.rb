class PicturesController < ApplicationController
  before_action :set_city
  load_and_authorize_resource

  def index
    @pictures = Picture.all
    #pictures deren squat_id(Squat) zu city gehört ()

  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = Picture.create(picture_params)
    redirect_to city_pictures_path(@city)
  end

  private

  def picture_params
    params.require(:picture).permit(:title, :description, :picture)
  end


  def set_city
    @city = City.friendly.find(params[:city_id])
  end

end