require './spec/spec_helper'
describe Color do
  describe 'class methods' do
    describe 'meta collors' do
      it 'white should represent O' do
        Color.white.should == 'O'
      end
      it 'red should represent R' do
        Color.red.should == 'R'
      end
      #@ todo refactor meta tests to be dynamic
    end
  end
  describe 'initialize' do
    context 'one char string argument' do
      it 'shold not raise error'do
        lambda{ Color.new('O')}.should_not raise_error
      end
    end

    context "two char string argument" do
      it 'should raise error' do
        lambda{ Color.new('OO')}.should raise_error
      end
    end

    context "other than String object argument" do
      it 'should raise error' do
        lambda{ Color.new(Hash.new)}.should raise_error
      end
    end

    it 'should set @char_color  in upcase' do
      instance = Color.new('o') #downcase
      instance.instance_variable_get('@char_color').should == 'O' #upcase
    end
  end
end
