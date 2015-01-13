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

  def get_default_icon
    asset_path( "icons/haus_grau.png" )
  end

  def city_start_year(city)
    Period.joins(:squat).where("squats.city_id": city).minimum(:start_year) || Date.today.year
  end

  def city_year_range(city)
    Range.new(city_start_year(city), Date.today.year).to_a.map{ |y| [y, y] }
  end

end
