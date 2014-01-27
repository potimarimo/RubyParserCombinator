require_relative 'spec_helper'
require 'ordered_choice'

include Rpc
describe OrderedChoice do
  subject { word('hello') / 'world' }
  describe '#parse' do
    it 'は解析を行い、結果を返します。' do
      subject.parse('hello').should == 'hello'
    end
    it 'は最初の単語を判別します。' do
      subject.parse('hello').should == 'hello'
    end
    it 'は二つ目の単語を判別します。' do
      subject.parse('world').should == 'world'
    end
  end
  describe '#to_s' do
    it 'は文法の並びを文字列として返します。' do
      subject.inspect.should == '("hello" / "world")'
    end
  end
  describe '#inspect' do
    it 'は文法の並びをわかりやすい文字列として返します。' do
      subject.inspect.should == '("hello" / "world")'
    end
  end
end