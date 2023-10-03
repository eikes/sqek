module SquatsHelper

  def squat_get_icon(squat)
    # temp fix for squats without periods
    if squat.periods.count == 0 || squat.periods.first.start_year.nil?
      return asset_path "svg/haus_grau.svg"
    end

    start_decade = [squat.periods.first.start_year / 10 * 10, 1960].max
    evicted = squat.periods.last.end_year.nil?

    if squat.tags.try(:include?, 'caravan_site')
      base = 'wagen'
    elsif squat.tags.try(:include?, 'occupied_public_space')
      base = 'zelt'
    else
      base = 'haus'
    end

    filename = "#{ base }_#{ start_decade }"

    if evicted
      filename += '_evicted'
    end

    if squat.tags.try(:include?, 'social_center')
      filename += '_sc'
    end

    asset_path "svg/#{ filename }.svg"
  end

end
