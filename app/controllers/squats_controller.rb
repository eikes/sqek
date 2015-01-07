class SquatsController < ApplicationController
  before_action :set_squat, only: [:show, :edit, :update, :destroy]
  before_action :set_city

  load_and_authorize_resource

  respond_to :html, :json

  def index
    @squats = @city.squats
    respond_with(@squats)
  end

  def show
    respond_with(@squat)
  end

  def new
    @squat = Squat.new
    @squat.periods.build
    respond_with(@squat)
  end

  def edit
  end

  def create
    @squat = Squat.new(squat_params)
    @squat.save
    @squat.update(city: @city)
    flash[:notice] = "Squat created."
    respond_with(@city, @squat)
  end

  def update
    @squat.update(squat_params)
    @squat.update(city: @city)
    flash[:notice] = "Squat updated."
    respond_with(@city, @squat)
  end

  def destroy
    @squat.destroy
    respond_with(@city, @squat)
  end

  private
    def set_squat
      @squat = Squat.friendly.find(params[:id])
    end

    def set_city
      @city = City.friendly.find(params[:city_id])
    end

    def squat_params
      params.require(:squat).permit(:name, :body, :address, :lat, :lng, 
        periods_attributes: [:id, 
          :start_year, :start_month, :start_day, 
          :end_year, :end_month, :end_day, 
          :_destroy])
    end
end