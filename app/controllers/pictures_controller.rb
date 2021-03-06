class PicturesController < ApplicationController
  before_action :set_city
  before_action :set_picture, only: [:update]
  load_and_authorize_resource

  respond_to :html, :json

  def index
    @squats = @city.squats
    @pictures = @city.pictures
  end

  def show
  end

  def new
    @picture = Picture.new
    if params[:squat_id]
      @picture.squats << Squat.find(params[:squat_id])
    end
  end

  def create
    @picture = Picture.new(picture_params)
    @picture.squats = Squat.find(params[:picture][:squat_ids].delete_if { |id| id.empty? })
    # assign the current user, because the squat is invalid otherwise, which causes the picture upload to fail.
    @picture.squats.each { |squat| squat.current_user = current_user }
    if @picture.save
      flash[:notice] = "Picture created"
      redirect_to city_picture_path(@city, @picture)
    else
      flash[:error] = "Picture could not be created: #{@picture.errors.full_messages.join('. ')}"
      render 'new'
    end
  end

  def update
    if @picture.update(picture_params)
      flash[:notice] = "Picture updated"
      redirect_to city_pictures_path(@city)
    else
      flash[:error] = "Picture could not be updated: #{@picture.errors.full_messages.join('. ')}"
      render 'edit'
    end
  end

  def destroy
    @picture.destroy
    redirect_to city_pictures_path(@city)
  end

  private

  def picture_params
    params.require(:picture).permit(:title, :description, :picture, squat_ids: [])
  end


  def set_city
    @city = City.friendly.find(params[:city_id])
  end

  def set_picture
    @picture = Picture.find(params[:id])
  end

end