require_relative 'spec_helper'
require 'parsing_expression'

include Rpc
describe StartOfText do
  subject { StartOfText.new }
  describe 'start_of_text' do
    it 'でStartOfTextのインスタンスが取得できます。' do
      start_of_text.should be_an_instance_of StartOfText
    end
  end
  describe '#parse' do
    it 'は文章の最初を識別し、nilを返します。' do
      subject.parse('hello').should be_nil
    end
    it 'は並びの結果に含まれません。' do
      (subject + 'hello').parse('hello').should == ['hello']
    end
    it '文章の最初でなければ失敗します。' do
      (word('hello') + subject).parse('hello').should be_nil
    end
  end
  describe '#inspect' do
    it 'はstartを返します。' do
      subject.inspect.should == 'start'
    end
  end
  describe '#to_s' do
    it 'はstartを返します。' do
      subject.to_s.should == 'start'
    end
  end
end