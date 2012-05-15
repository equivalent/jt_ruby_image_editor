class Color
  @@availible_colors={:white => 'O', :red=>'R' }
  class << self
    @@availible_colors.each do |color, char|
      define_method :"#{color}" do
        char
      end
    end
  end

  def initialize(char_color)
    raise "Argument should be one char" unless char_color.is_a?(String) and char_color.length == 1
    @char_color = char_color.upcase

  end
end
