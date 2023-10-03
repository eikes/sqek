class LegendColors

  def self.until_now
    self.colors.select { |year, color| year.to_i != 0 && year.to_i < Time.zone.now.year }
  end

  # https://colorbrewer2.org/?type=qualitative&scheme=Paired&n=10
  def self.colors
    {
     'grau' => '#666666',

     '1960' => '#fdbf6f',
     '1970' => '#ff7f00',
     '1980' => '#e31a1c',
     '1990' => '#33a02c',

     '2000' => '#6a3d9a',
     '2010' => '#1f78b4',
     '2020' => '#a6cee3',
     '2030' => '#b2df8a',

     '2040' => '#cab2d6',
     '2050' => '#fb9a99'
    }
  end

end
