class SquatsController < ApplicationController
  before_action :set_squat, only: [:show, :edit, :update, :destroy, :version, :restore_version]
  before_action :set_city

  load_and_authorize_resource

  respond_to :html, :json

  def index
    @squats = @city.squats.includes(:periods).order(:name)
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
    @squat.city = @city
    @squat.save
    flash[:notice] = "Squat created."
    respond_with(@city, @squat)
  end

  def update
    @squat.update(squat_params)
    flash[:notice] = "Squat updated."
    redirect_to city_squats_path(@city, anchor: @squat.slug)
  end

  def destroy
    @squat.destroy
    respond_with(@city, @squat)
  end

  def version
    authorize! :read, PaperTrail::Version
    @squat = @squat.versions.select{ |version| version.id == params[:version_id].to_i }.first.reify
    render 'show'
  end

  def revert_to_version
    authorize! :read, PaperTrail::Version
    @version = @squat.versions.select{ |version| version.id == params[:version_id].to_i }.first.reify
    @version.save
    redirect_to city_squat_path(@city, @version)
  end

  private
    def set_squat
      @squat = Squat.find(params[:id])
    end

    def set_city
      @city = City.friendly.find(params[:city_id])
    end

    def squat_params
      params.require(:squat).permit(:name, :body, :link, :address, :lat, :lng,
        tags: [],
        periods_attributes: [:id, 
          :start_year, :start_month, :start_day, 
          :end_year, :end_month, :end_day, 
          :_destroy])
    end
end
