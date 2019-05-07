class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale
  before_action :set_cities

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def set_cities
    @cities = if current_user.present?
                City.all
              else
                City.joins(:squats).group(:city_id) # bit of a hack to only get cities with at least one squat
              end
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end

  def home
    redirect_to cities_path
  end

end
