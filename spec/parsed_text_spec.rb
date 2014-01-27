require_relative 'spec_helper'
require 'parsed_text'

include Rpc
describe ParsedText do
  subject { ParsedText.new('hello world') }
  describe '#to_s' do
    it 'はテキストを文字列として返します。' do
      subject.to_s.should == 'hello world'
    end
  end
  describe '#inspect' do
    it 'はテキストを現在位置を|であらわした文字列として返します。' do
      subject.index = 5
      subject.inspect.should == 'hello| world'
    end
  end
  describe '#string' do
    it 'はテキスト内容を返します。' do
      subject.string.should == 'hello world'
    end
  end
  describe '#index' do
    it 'の初期値は0です。' do
      subject.index.should == 0
    end
  end
  describe '#consumed' do
    it 'は消費された部分を返します。' do
      subject.index = 6
      subject.consumed.should == 'hello '
    end
  end
  describe '#not_consumed' do
    it 'は消費されていない部分を返します。' do
      subject.index = 6
      subject.not_consumed.should == 'world'
    end
  end
end