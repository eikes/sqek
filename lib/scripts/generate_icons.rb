# cd lib/scripts
# ruby generate_icons.rb

require "erb"

class Icon
  extend ERB::DefMethod
  def initialize(color, evicted, label)
    @color = color
    @evicted = evicted
    @label = label
  end
end

class Haus < Icon
  def_erb_method('render()', '../../app/views/icons/haus.svg.erb')
end

class Wagen < Icon
  def_erb_method('render()', '../../app/views/icons/wagen.svg.erb')
end

class Zelt < Icon
  def_erb_method('render()', '../../app/views/icons/zelt.svg.erb')
end

colors = {
 '1960' => '#f7a800',
 '1970' => '#e94e24',
 '1980' => '#c90c0f',
 '1990' => '#25431e',
 '2000' => '#63425a',
 '2010' => '#0b6973'
}

[Haus, Wagen, Zelt].each do |klass|
  [false, 'h', 'sc', 'hsc'].each do |label|
    [true, false].each do |evicted|
      colors.each do |year, color|
        filename = "../../app/assets/images/svg/#{ klass.name.downcase }_#{ year }"
        if evicted
          filename += '_evicted'
        end
        if label
          filename += "_#{ label }"
        end
        filename += ".svg"
        svg = klass.new(color, evicted, label).render()
        File.open(filename, 'w') { |file| file.write(svg) }
      end
    end
  end
end
