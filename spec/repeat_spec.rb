require_relative 'spec_helper'
require 'parsing_expression'

include Rpc
describe Repeat do
  let(:hello){ word('hello') }
  subject { hello * (2..3) }
  describe '#parse' do
    it 'は最少回数以下の繰り返しでは一致しません。' do
      subject.parse('hello').should == nil
    end
    it 'は一致しなかった場合はテキストを消費しません。' do
      text = ParsedText.new('hello')
      subject.parse(text)
      text.index.should == 0
    end
    it 'は最少回数の繰り返しに一致します。' do
      subject.parse('hello hello').should == ['hello', 'hello']
    end
    it 'は最大回数の繰り返しに一致します。' do
      subject.parse('hello hello, hello').should == ['hello', 'hello', 'hello']
    end
    it 'は最大回数の繰り返しまでに一致します。' do
      subject.parse('hello hello, hello hello').should == ['hello', 'hello', 'hello']
    end
  end
end