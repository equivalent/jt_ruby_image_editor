class Editor

  attr_reader :image

  def initialize(width, height)
    argument_is_number?(width, height)
    argument_over_zero?(width, height)
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
        row_array << default_color
      end
      @image << row_array
    end
    return image
  end

  def paint_pixel(horizontal, vertical, color)
    argument_is_number?(horizontal, vertical)
    argument_over_zero?(horizontal, vertical)
    @image[vertical - 1][horizontal - 1] = Color.new(color).display_color
  end

  def line_horizontal(x1, x2, y, color)
    @image[(y-1)].each_index do |column_index|
    paint_area = (x1-1)..(x2-1)
      @image[(y-1)][column_index] = Color.new(color).display_color if paint_area.include?(column_index)
    end
  end



  def show
    @image.each do |row|
      puts row.join
    end
  end

  def default_color
    color_klass.white
  end

private

  def color_klass
    Color
  end

  def argument_is_number?(*args)
    args.select!{|a| (! a.is_a?(Integer))}
    if arg = args[0]
      raise "Argument \"#{arg.to_s}\" should be pixel numbers"
    end
  end

  def argument_over_zero?(*args)
    args.select!{|a| a <= 0}
      raise "Arguments should be NUMBERS greater than zero" if args[0]
  end

end
