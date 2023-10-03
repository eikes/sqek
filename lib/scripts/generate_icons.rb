# cd lib/scripts
# ruby generate_icons.rb

require "erb"
require __dir__ + '/../../config/initializers/legend_colors.rb'

class Icon
  extend ERB::DefMethod
  def initialize(color, evicted, label)
    @color = color
    @evicted = evicted
    @label = label
  end
end

class Haus < Icon
  def_erb_method('render()', __dir__ + '/../../app/views/icons/haus.svg.erb')
end

class Wagen < Icon
  def_erb_method('render()', __dir__ + '/../../app/views/icons/wagen.svg.erb')
end

class Zelt < Icon
  def_erb_method('render()', __dir__ + '/../../app/views/icons/zelt.svg.erb')
end

[Haus, Wagen, Zelt].each do |klass|
  [false, 'sc'].each do |label| # 'h', 'hsc',
    [true, false].each do |evicted|
      LegendColors.colors.each do |year, color|
        filename = __dir__ + "/../../app/assets/images/svg/#{ klass.name.downcase }_#{ year }"
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
