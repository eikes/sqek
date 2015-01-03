class Period < ActiveRecord::Base
  belongs_to :squat

  validates :start_year, presence: true
  validates :start_month, presence: true, if: :start_day
  validates :end_year, presence: true, if: :end_month
  validates :end_month, presence: true, if: :end_day

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
      start_string = I18n.t(:period_from).capitalize + ": " + start_string
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
      end_string = I18n.t(:period_to) + ": " + end_string
    end

    if !end_string.blank?
      start_string + " - " + end_string
    else 
      start_string
    end

  end

end
