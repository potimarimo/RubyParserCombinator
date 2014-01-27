require_relative 'spec_helper'
require 'parsing_expression'

include Rpc

describe AndPredicate do
  subject { word('hello') + word('world').& }
  describe '#parse' do
    it 'は先読みに失敗した場合は失敗となります。' do
      subject.parse('hello').should be_nil
    end
    it 'は再帰読みに成功しても読み込まれません。' do
      subject.parse('hello world').should == ['hello']
    end
  end
  describe '#inspect' do
    it 'は(parsing_expression)-という形式を返します。' do
      subject.inspect.should == '("hello" + &"world")'
    end
  end
  describe '#to_s' do
    it 'は(parsing_expression)-という形式を返します。' do
      subject.to_s.should == '("hello" + &"world")'
    end
  end
end