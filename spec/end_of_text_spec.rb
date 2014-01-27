require_relative 'spec_helper'
require 'parsing_expression'

include Rpc
describe EndOfText do
  subject { EndOfText.new }
  describe 'end_of_text' do
    it 'でEndOfTextのインスタンスが取得できます。' do
      end_of_text.should be_an_instance_of EndOfText
    end
  end
  describe '#parse' do
    it 'は文章の最後を識別し、nilを返します。' do
      subject.parse('').should be_nil
    end
    it 'は並びの結果に含まれません。' do
      (word('hello') + subject).parse('hello').should == ['hello']
    end
    it '文章の最後でなければ失敗します。' do
      (subject + 'hello').parse('hello').should be_nil
    end
  end
  describe '#inspect' do
    it 'はendを返します。' do
      subject.inspect.should == 'end'
    end
  end
  describe '#to_s' do
    it 'はendを返します。' do
      subject.to_s.should == 'end'
    end
  end
end