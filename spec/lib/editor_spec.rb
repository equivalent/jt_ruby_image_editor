require './spec/spec_helper'

def check_white(editor_image)
  editor_image.each do |image_row|
    image_row.each do |image_coll|
      image_coll.should == editor.default_color
    end
  end
end

describe Editor do
  let(:editor){ Editor.new(7, 11) }

  describe 'initialize' do
    it 'should set @width and should set @height' do
      editor = Editor.new(7, 11)
      editor.instance_variable_get('@width').should == 7
      editor.instance_variable_get('@height').should == 11
    end

    context 'arguments for width and height else than number' do
      it 'should raise error' do
        lambda{ Editor.new('a', 11) }.should raise_error
        lambda{ Editor.new(11, 'a') }.should raise_error
        lambda{ Editor.new('b', 'a') }.should raise_error
      end
    end

    context "when width or height is zero" do
      it 'should raise error' do
        lambda{ Editor.new(0, 11) }.should raise_error
        lambda{ Editor.new(11, 0) }.should raise_error
      end
    end

    xit 'should call instance method initialize_image' do
      o = Editor.new(7,11)
      o.should_receive(:initialize_image).once
    end
  end

  describe 'initialize_image instance method' do
    it 'should set @image as 2D array with values of white color' do
      editor.initialize_image
      editor.image.size.should be 11
      editor.image.first.size.should be 7
    end

    it 'should panit pixels with default color' do
      check_white(editor.image)
    end
  end

  describe 'clear instance method' do
    it 'should call initialize_image' do
      editor.should_receive(:initialize_image).once
      editor.clear
    end
  end

  describe 'paint_pixel instance method' do
    it 'should paint one pixel at position with color' do
      editor.paint_pixel(2, 3, 'C')
      editor.instance_variable_get('@image')[3 - 1][2 - 1].should == 'C'
    end
    it 'other segments should stay default color' do
      editor.paint_pixel(2, 3, 'C')
      image = editor.instance_variable_get('@image')
      image[3 - 1][2 - 1] = 'O'
      check_white(image)
    end
  end

  describe 'line_horizontal instance method' do
    it "should paint specified pixels on the row and keep rest" do
      editor.line_horizontal(2, 6, 3, 'C')
      image = editor.instance_variable_get('@image')
      image_row = image[3-1]
      image.each_index do |row_index|
        unless row_index == 2
          image[row_index].each do |column|
            column.should == 'O'
          end
        end
      end

      # OCCCCCO
      
      #painted
      #
      image_row[(2-1)..(6-1)].each do |column|
        column.should == 'C'
      end
      #unpainted
      image_row[(1-1)].should == editor.default_color
      image_row[(7-1)].should == editor.default_color
    end

    xit 'should set color from Color class display color'
  end

  describe 'draw_vertical instance method' do
    it "should paint specified pixels on the column and keep rest" do
      editor.line_vertical(3, 2, 6, 'C')
      puts ''
      image = editor.instance_variable_get('@image')
      image_rows = (2-1)..(6-1)

      image.each_index do |row_index|
        if(image_rows.include?(row_index))
          image[row_index].each_index do |column_index|
             column = image[row_index][column_index]
             (column_index == (3-1)) ? (column.should == 'C') : (column.should == 'O')
          end
        else
          image[row_index].each do |column|
            column.should == 'O'
          end
        end
      end
    end
    xit 'should set color from Color class display color'
  end

  describe 'default_color instance method' do
    it 'should be "O"' do
      editor.send(:default_color).should == 'O'
    end
  end

  describe 'argument_is_number? private instance method' do
    it 'should raise error when passing char' do 
      lambda{editor.send(:argument_is_number?, 9, 'C')}.should raise_error("Argument \"C\" should be pixel numbers"
)
    end

    it 'should not raise error when passing multiple arguments all numbers' do
      lambda{editor.send(:argument_is_number?, 9, 1, 5, 10)}.should_not raise_error
    end
  end

  describe 'argument_over_zero? private instance method' do
    it 'should raise error when passing number lower that 1' do 
      lambda{editor.send(:argument_over_zero?, 9, 0)}.should raise_error("Arguments should be NUMBERS greater than zero")
    end

    it 'should not raise error when passing multiple arguments all numbers' do
      lambda{editor.send(:argument_over_zero?, 9, 1, 5, 10)}.should_not raise_error
    end
  end

end
