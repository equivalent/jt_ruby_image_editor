require './spec/spec_helper'
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
      editor.image.each do |image_row|
        image_row.each do |image_coll|
          image_coll.should be editor.deffault_collor
        end
      end
    end
  end

  describe 'clear instance method' do
    it 'should call initialize_image' do
      editor.should_receive(:initialize_image).once
      editor.clear
    end
  end

  describe 'paint_pixel instance method' do
    it 'should accept horizontal_position, vertical_position, and color as argument'
    it 'should paint one pixel at position with color'
  end

  describe 'deffault_collor instance method' do
    it 'should be O' do
      editor.send(:deffault_collor).should == 'O'
    end
  end
  
end
