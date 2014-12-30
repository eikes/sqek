class SquatsController < ApplicationController
  before_action :set_squat, only: [:show, :edit, :update, :destroy]
  before_action :set_city

  load_and_authorize_resource

  respond_to :html, :json

  def index
    @squats = Squat.all
    @squats_marker = @squats.map{ |squat| squat_to_marker(squat) }
    respond_with(@squats)
  end

  def show
    @squats = [squat_to_marker(@squat)]
    respond_with(@squat)
  end

  def new
    @squat = Squat.new
    respond_with(@squat)
  end

  def edit
  end

  def create
    @squat = Squat.new(squat_params)
    @squat.save
    respond_with(@city, @squat)
  end

  def update
    @squat.update(squat_params)
    respond_with(@city, @squat)
  end

  def destroy
    @squat.destroy
    respond_with(@city, @squat)
  end

  private
    def set_squat
      @squat = Squat.find(params[:id])
    end

    def set_city
      @city = City.find(params[:city_id])
    end

    def squat_params
      params.require(:squat).permit(:name, :body, :lat, :lng)
    end

    def squat_to_marker(squat)
      {
        latlng: squat.latlng,
        popup: "<a href=\"#{city_squat_path(@city, squat)}\">#{squat.name}</a>"
      }
    end
end
