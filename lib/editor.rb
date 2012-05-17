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

  def paint_pixel(x, y, color)
    vaild_pixel_position?(x, y)
    @image[y-1][x-1] = Color.new(color).display_color
  end

  def line_horizontal(x1, x2, y, color)
    @image[(y-1)].each_index do |row_index|
      @image[(y-1)].fill(Color.new(color).display_color,(x1-1)..(x2-1))
    end
  end

  def line_vertical(x, y1, y2, color)
    vertical_area = (y1-1)..(y2-1)
    @image.each_index do |row_index|
      next unless vertical_area.include?(row_index)
      @image[row_index][x-1] = Color.new(color).display_color
    end
  end

  def fill(x, y, color)
    color = Color.new(color).display_color
    paint_recursive(x-1, y-1, @image[y-1][x-1], color) 
  end

  def show
    @image.each{|row| puts row.join}
    nil
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

  def vaild_pixel_position?(*args)
    argument_is_number?(*args) and argument_over_zero?(*args)
  end

  def paint_recursive(horizontal, vertical, original_color, new_color)
    return unless vertical >= 0 and horizontal >= 0 and vertical < @image.size and horizontal < @image.first.size #position shouldn't be out of image array
    return unless @image[vertical][horizontal] == original_color
    return if     @image[vertical][horizontal] == new_color # return if already painted

    @image[vertical][horizontal] = new_color

    [[1,0],[-1,0],[-1,1],[0,1],[1,1],[-1,-1],[0,-1],[1,-1]].each do |marker|  #calling on pixels around 
      paint_recursive( (horizontal + marker.first), (vertical + marker.last), original_color, new_color)
    end
    return nil
  end
end
