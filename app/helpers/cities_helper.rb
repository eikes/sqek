module CitiesHelper

  def statistics(city)
    stats = {}
    min = city.squats.published.joins(:periods).minimum(:start_year)
    max = Date.today.year
    (min..max).to_a.each do |y|
      stats[y] = {
        squattings: 0,
        evictions:  0,
        total:      0
      }
    end
    city.squats.each do |squat|
      squat.periods.each do |period|
        stats[period.start_year][:squattings] += 1
        if period.end_year
          stats[period.end_year][:evictions] += 1
        end
      end
    end
    total = 0
    stats.each do |year, stat|
      total += stats[year][:squattings]
      stats[year][:total] = total
      total -= stats[year][:evictions]
    end
    stats
  end

end
