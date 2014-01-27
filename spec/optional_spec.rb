require_relative 'spec_helper'
require 'parsing_expression'

include Rpc
describe Optional do
  subject { word('hello') + word('world').- }
  describe '#parse' do
    it 'は成功した場合は読み込めます。' do
      subject.parse('hello world').should == ['hello', 'world']
    end
    it 'は一致が複数の場合に配列として認識されます。' do
      subject.parse('hello').should == ['hello']
    end
  end
  describe '#inspect' do
    it 'は(parsing_expression)-という形式を返します。' do
      subject.inspect.should == '("hello" + "world"-)'
    end
  end
  describe '#to_s' do
    it 'は(parsing_expression)-という形式を返します。' do
      subject.to_s.should == '("hello" + "world"-)'
    end
  end
end