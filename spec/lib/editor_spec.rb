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

    it 'should initialize image' do
      o = Editor.new(7,11)
      image = o.instance_variable_get('@image')
      o.send(:initialize_image)
      image.should == o.instance_variable_get('@image')
    end
  end

  describe 'initialize_image instance method' do
    it 'should set @image as 2D array with values of white color' do
      editor.send(:initialize_image)
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
    it 'should call validate_pixel_position!' do
      editor.should_receive(:validate_pixel_position!).once.with([1],[2]) 
      editor.paint_pixel(1,2,'C')
    end

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
    it 'should call validate_pixel_position!' do
      editor.should_receive(:validate_pixel_position!).once.with([1,2],[3]) 
      editor.line_horizontal(1,2,3,'C')
    end

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

    it 'should set color from display_color' do
      editor.should_receive(:display_color).with('C').once
      editor.line_horizontal(2, 6, 3, 'C')
    end
  end

  describe 'draw_vertical instance method' do
    it 'should call validate_pixel_position!' do
      editor.should_receive(:validate_pixel_position!).once.with([1],[2,3]) 
      editor.line_vertical(1,2,3,'C')
    end

    it "should paint specified pixels on the column and keep rest" do
      editor.line_vertical(3, 2, 6, 'C')
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

  describe 'fill' do
    it 'should call validate_pixel_position!' do
      editor.should_receive(:validate_pixel_position!).once.with([1],[2]) 
      editor.fill(1,2,'C')
    end

  end

  describe 'validate_pixel_position! private instance method' do
    it 'should call validate_pixel_scale' do
      editor.should_receive(:validate_pixel_scale!).once.with(1,2,3) 
      editor.send(:validate_pixel_position!, [1,2],[3])
    end

    it 'should raise error when vertical position is out of range' do
      lambda{editor.send(:validate_pixel_position!, [1],[20])}.should raise_error(/in image range/)
    end

    it 'should raise error when horizontal is out of range' do
      lambda{editor.send(:validate_pixel_position!, [100],[2])}.should raise_error(/in image range/)
    end

    it 'should raise error when both horizontal and vertical is out of range' do
      lambda{editor.send(:validate_pixel_position!, [100],[200])}.should raise_error(/in image range/)
    end

    it 'should not raise error when horizontal and vertical is in the range' do
      lambda{editor.send(:validate_pixel_position!, [1],[2])}.should_not raise_error
    end
  end

  describe 'validate_pixel_scale! private instance method' do
    it 'should call argument_must_be_number and argument_over_zero!' do
      editor.should_receive(:argument_must_be_number!).once.with(1,2,3) 
      editor.should_receive(:argument_over_zero!).once.with(1,2,3) 
      editor.send(:validate_pixel_scale!, 1,2,3)
    end
  end

  describe 'argument_must_be_number! private instance method' do
    it 'should raise error when passing char' do 
      lambda{editor.send(:argument_must_be_number!, 9, 'C')}.should raise_error("Argument \"C\" should be pixel numbers"
                                                                               )
    end

    it 'should not raise error when passing multiple arguments all numbers' do
      lambda{editor.send(:argument_must_be_number!, 9, 1, 5, 10)}.should_not raise_error
    end
  end

  describe 'argument_over_zero! private instance method' do
    it 'should raise error when passing number lower that 1' do 
      lambda{editor.send(:argument_over_zero!, 9, 0)}.should raise_error("Arguments should be NUMBERS greater than zero")
    end

    it 'should not raise error when passing multiple arguments all numbers' do
      lambda{editor.send(:argument_over_zero!, 9, 1, 5, 10)}.should_not raise_error
    end
  end

end
