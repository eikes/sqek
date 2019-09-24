class Period < ApplicationRecord
  belongs_to :squat

  default_scope { order(:start_year, :start_month, :start_day) }

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

  def start_string
    sub_string "start"
  end

  def end_string
    sub_string "end"
  end

  def sub_string(sub)
    result = ""
    if self[sub + "_day"]
      result << self[sub + "_day"].to_s + ". "
    end
    if self[sub + "_month"]
      result << I18n.t("date.month_names")[self[sub + "_month"]] + " "
    end
    if self[sub + "_year"]
      result << self[sub + "_year"].to_s
    end
    result
  end

  def to_s
    result = ""

    unless start_string.blank?
      if start_day.blank? and start_month.blank?
        result << I18n.t(:squatted_in_year, date: start_string)
      elsif start_day.blank?
        result << I18n.t(:squatted_in_month, date: start_string)
      else
        d = Date.new(start_year, start_month, start_day)
        result << I18n.t(:squatted_on_day, date: d.strftime(I18n.t('date.formats.long')))
      end
    end

    unless end_string.blank?
      result << "\n"
      if end_day.blank? and end_month.blank?
        result << I18n.t(:evicted_in_year, date: end_string)
      elsif end_day.blank?
        result << I18n.t(:evicted_in_month, date: end_string)
      else
        d = Date.new(end_year, end_month, end_day)
        result << I18n.t(:evicted_on_day, date: d.strftime(I18n.t('date.formats.long')))
      end
    end

    result
  end

end
