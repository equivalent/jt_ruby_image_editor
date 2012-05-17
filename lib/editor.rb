class Editor
  attr_reader :image

  def initialize(width, height)
    validate_pixel_scale!(width, height)
    @width  = width
    @height = height
    initialize_image
  end

  def clear
    initialize_image
  end

  def paint_pixel(x, y, color)
    validate_pixel_position!([x], [y])
    @image[y-1][x-1] = Color.new(color).display_color
  end

  def line_horizontal(x1, x2, y, color)
    validate_pixel_position!([x1, x2], [y])
    @image[(y-1)].each_index do |row_index|
      @image[(y-1)].fill(Color.new(color).display_color,(x1-1)..(x2-1))
    end
  end

  def line_vertical(x, y1, y2, color)
    validate_pixel_position!([x], [y1, y2])
    vertical_area = (y1-1)..(y2-1)
    @image.each_index do |row_index|
      next unless vertical_area.include?(row_index)
      @image[row_index][x-1] = Color.new(color).display_color
    end
  end

  def fill(x, y, color)
    validate_pixel_position!([x], [y])
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

  ### validations
  def validate_pixel_scale!(*args)
    argument_must_be_number!(*args) 
    argument_over_zero!(*args)
  end

  def validate_pixel_position!(x_array, y_array)
    arguments=[x_array,y_array].flatten
    validate_pixel_scale!(*arguments)
    raise "Arguments must be in image range height:\"#{@height}\" width:\"#{@width}\"" if x_array.select{|a| a.to_i > @width}.any? || y_array.select{|a| a.to_i > @height}.any?
  end

  def argument_must_be_number!(*args)
    args.select!{|a| (! a.is_a?(Integer))}
    if arg = args[0]
      raise "Argument \"#{arg.to_s}\" should be pixel numbers"
    end
  end

  def argument_over_zero!(*args)
    args.select!{|a| a.to_i <= 0}
      raise "Arguments should be NUMBERS greater than zero" if args.any?
  end

  ### image manipulation
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
end
