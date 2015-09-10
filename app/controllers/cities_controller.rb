class CitiesController < ApplicationController
  before_action :set_city, only: [:show, :edit, :update, :destroy]

  load_and_authorize_resource

  respond_to :html, :json

  def index
    @cities = City.all
    respond_with(@cities)
  end

  def show
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
    redirect_to city_squats_path(@city)
  end

  def destroy
    @city.destroy
    respond_with(@city)
  end

  private
    def set_city
      @city = City.friendly.find(params[:id])
    end

    def city_params
      params.require(:city).permit(:name, :body, :lat, :lng, :external_url)
    end
end
