class Editor

  attr_reader :image

  def initialize(width, height)
    raise "Arguments should be pixel numbers" unless width.is_a?(Integer) and height.is_a?(Integer)
    raise "Arguments should greater than zero" unless (width > 0) and (height > 0)
    @width  = width
    @height = height
    initialize_image
  end

  def clear
    initialize_image
  end

  def initialize_image
    @image = []
    @height.times do |row|
      row_array = []
      @width.times do |column|
        row_array << deffault_collor
      end
      @image << row_array
    end
    return image
  end

  def paint_pixel(horizontal, vertical, color)
    @image[vertical - 1][horizontal - 1] = Color.new(color).display_color
  end

  def deffault_collor
    color_klass.white
  end

private

  def color_klass
    Color
  end
end
