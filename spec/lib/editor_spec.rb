describe Editor do
  describe 'initialize' do
    it 'should set @width and should set @height'
    it 'width and height should be numbers'
    it 'should call instance method initialize_image' 
  end

  describe 'initialize_image instance method' do
    it 'should set @image as 2D array with values of white color'
  end

  desribe 'clear instance method' do
    it 'should reset image to white color'
  end

  describe 'paint_pixel instance method' do
    it 'should accept horizontal_position, vertical_position, and color as argument'
    it 'should paint one pixel at position with color'
  end

  
end
