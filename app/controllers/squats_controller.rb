class SquatsController < ApplicationController
  before_action :set_city

  load_and_authorize_resource except: [:new, :create]

  respond_to :html, :json, :kml, :xlsx

  def index
    if @city.external_url.present?
      redirect_to @city.external_url
    else
      @squats_url = city_squats_path(@city, format: :json)
      @squats = @city.squats
                     .published
                     .includes(:periods)
                     .includes(:pictures)
                     .order(:name)
      respond_with(@squats) do |format|
        format.xlsx do
          response.headers['Content-Disposition'] = "attachment; filename=\"#{@city.slug}_squats.xlsx\""
        end
      end
    end
  end

  def unpublished
    @squats_url = unpublished_city_squats_path(@city, format: :json)
    @squats = @city.squats
                   .unpublished
                   .includes(:periods)
                   .includes(:pictures)
                   .order(:name)
    respond_with(@squats, template: 'squats/index')
  end

  def show
    respond_with(@squat)
  end

  def new
    @squat = Squat.new
    @squat.periods.build
    @squat.address_city = @city.name
    authorize! :create, @squat, @city
    respond_with(@squat)
  end

  def edit
  end

  def create
    @squat = Squat.new(squat_params)
    authorize! :create, @squat, @city

    @squat.city = @city
    @squat.current_user = current_user
    @squat.published = current_user.present?

    if @squat.save
      if current_user.nil?
        recipients = @city.users.pluck(:email)
        NotificationsMailer.squat_notification(recipients, @squat).deliver_now
        flash[:notice] = t(:squat_submitted_for_review)
      else
        flash[:notice] = t(:squat_created)
      end
    end
    respond_with(@city, @squat)
  end

  def update
    @squat.current_user = current_user
    if @squat.update(squat_params)
      flash[:notice] = t(:squat_updated)
      redirect_to city_squats_path(@city, anchor: @squat.slug)
    else
      render 'edit'
    end
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

    def set_city
      @city = City.friendly.find(params[:city_id])
    end

    def squat_params
      params.require(:squat).permit(
        :name, :body, :link, :address, :address_city, :lat, :lng, :external_user_email, :published,
        tags: [],
        periods_attributes: [:id,
          :start_year, :start_month, :start_day,
          :end_year, :end_month, :end_day,
          :_destroy
        ]
      )
    end
end
