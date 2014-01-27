require_relative 'spec_helper'
require 'parsing_expression'

include Rpc
describe ZeroOrMore do
  subject { word('hello').* }
  describe '#parse' do
    it 'は一致がない場合に0要素の配列として認識されます。' do
      subject.parse('world').should == []
    end
    it 'は一致が複数の場合に配列として認識されます。' do
      subject.parse('hello hello').should == ['hello', 'hello']
    end
  end
  describe '#inspect' do
    it 'は(parsing_expression)*という形式を返します。' do
      subject.inspect.should == '"hello"*'
    end
  end
  describe '#to_s' do
    it 'は(parsing_expression)*という形式を返します。' do
      subject.to_s.should == '"hello"*'
    end
  end
end