class Period < ActiveRecord::Base
  belongs_to :squat

  validates :start_year, presence: true
  validates :start_month, presence: true, if: :start_day
  validates :end_year, presence: true, if: :end_month
  validates :end_month, presence: true, if: :end_day
  validates :start_year,
            :end_year,
            inclusion: { in: 1900..Date.today.year },
            allow_blank: true
  validates :start_month,
            :end_month,
            inclusion: { in: 1..12 },
            allow_blank: true
  validates :start_day,
            :end_day,
            inclusion: { in: 1..31 },
            allow_blank: true
  validates :end_year,
            numericality: { greater_than_or_equal_to: :start_year },
            allow_blank: true,
            if: :end_year

  def to_s

    start_string = ""
    if start_year
      start_string << start_year.to_s
    end
    if start_month
      start_string << "-" + start_month.to_s
    end
    if start_day
      start_string << "-" + start_day.to_s
    end

    unless start_string.blank?
      start_string = I18n.t(:period_from).capitalize + " " + start_string
    end

    end_string = ""
    if end_year
      end_string << end_year.to_s
    end
    if end_month
      end_string << "-" + end_month.to_s
    end
    if end_day
      end_string << "-" + end_day.to_s
    end

    unless end_string.blank?
      end_string = I18n.t(:period_to) + " " + end_string
    end

    if !end_string.blank?
      start_string + " " + end_string
    else 
      start_string
    end

  end

end
