module SquatsHelper

  def squat_get_icon(squat)
    if squat.periods.last.end_year.nil?
      asset_path( "icons/haus_#{(squat.periods.first.start_year/10*10).to_s}er.png" )
    else
      asset_path( "icons/haus_geraumt.png" )
    end
  end

end
