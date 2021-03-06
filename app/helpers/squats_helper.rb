module SquatsHelper

  def squat_get_icon(squat)
    # temp fix for squats without periods
    if squat.periods.count == 0 || squat.periods.first.start_year.nil?
      return asset_path "icons/haus_grau.png"
    end

    start_decade = [squat.periods.first.start_year / 10 * 10, 1960].max
    inhabited = squat.periods.last.end_year.nil?

    if squat.tags.try(:include?, 'caravan_site')
      if inhabited
        asset_path "icons/wagenplatz_#{ start_decade }er.png"
      else
        asset_path "icons/wagenplatz_evicted_#{ start_decade }er.png"
      end
    elsif squat.tags.try(:include?, 'occupied_public_space')
      if inhabited
        asset_path "icons/zelt_#{ start_decade }er.png"
      else
        asset_path "icons/zelt_geraumt.png"
        asset_path "icons/zelt_evicted_#{ start_decade }er.png"
      end
    else
      if inhabited
        asset_path "icons/haus_#{ start_decade }er.png"
      else
        asset_path "icons/haus_evicted_#{ start_decade }er.png"
      end
    end
  end

end
