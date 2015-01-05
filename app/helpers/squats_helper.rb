module SquatsHelper

  def squat_get_icon(squat)
    asset_path( "icons/haus_#{(squat.periods.first.start_year/10*10).to_s}er.png" )
  end

end
