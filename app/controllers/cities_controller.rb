class CitiesController < ApplicationController
  before_action :set_city, only: [:show, :edit, :update, :destroy]

  load_and_authorize_resource

  respond_to :html

  def index
    @cities = City.all.map{ |city| city_to_marker(city) }
    respond_with(@cities)
  end

  def show
    @cities = [city_to_marker(@city)]
    respond_with(@city)
  end

  def new
    @city = City.new
    respond_with(@city)
  end

  def edit
  end

  def create
    @city = City.new(city_params)
    @city.save
    flash[:notice] = "City created."
    respond_with(@city)
  end

  def update
    @city.update(city_params)
    flash[:notice] = "City updated."
    respond_with(@city)
  end

  def destroy
    @city.destroy
    respond_with(@city)
  end

  private
    def set_city
      @city = City.find(params[:id])
    end

    def city_params
      params.require(:city).permit(:name, :body, :lat, :lng)
    end

    def city_to_marker(city)
      {
        latlng: city.latlng,
        popup: "<a href=\"#{city_squats_path(city)}\">#{city.name}</a>"
      }
    end
end
