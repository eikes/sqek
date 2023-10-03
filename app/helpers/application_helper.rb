module ApplicationHelper

  BOOTSTRAP_FLASH_MSG = {
    success: 'alert-success',
    error:   'alert-danger',
    alert:   'alert-warning',
    notice:  'alert-info'
  }

  def bootstrap_class_for(flash_type)
    BOOTSTRAP_FLASH_MSG.fetch(flash_type.to_sym)
  end

  LANGUAGES = {
    de: 'Deutsch',
    en: 'English'
  }

  def language_for(language)
    LANGUAGES.fetch(language.to_sym)
  end

  def get_default_icon
    asset_path( "svg/haus_grau.svg" )
  end

  def city_start_year(city)
    Period.joins(:squat).where("squats.city_id = :city", city: city).minimum(:start_year) || Date.today.year
  end

end
