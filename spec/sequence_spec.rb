require_relative 'spec_helper'
require 'sequence'

include Rpc
describe Sequence do
  subject { word('hello') + word('world') }
  describe '#parse' do
    it 'は解析を行い、結果を返します。' do
      subject.parse('hello world').should == ['hello', 'world']
    end
    it 'は最初の単語を判別します。' do
      subject.parse('helle world').should be_nil
    end
    it 'は二つ目の単語を判別します。' do
      subject.parse('hello worlde').should be_nil
    end
    it 'は二つ目の判別に失敗した場合はテキストを消費しません。' do
      text = ParsedText.new('hello worlde')
      subject.parse(text)
      text.index.should == 0
    end
    it 'は最初にスペースがあっても正常に機能します。' do
      subject.parse(' hello world').should == ['hello', 'world']
    end
    it 'は最後にスペースがあっても正常に機能します。' do
      subject.parse('hello world ').should == ['hello', 'world']
    end
    it 'はnilを返す結果を含めません' do
      (subject + end_of_text).parse('hello world').should == ['hello', 'world']
    end
    it 'は直下の0以上の繰り返しは平滑化して返します。' do
      (subject + token('!').*).parse('hello world!!').should == ['hello', 'world', '!', '!']
    end
    it 'は直下の1以上の繰り返しは平滑化して返します。' do
      (subject + token('!').+).parse('hello world!!').should == ['hello', 'world', '!', '!']
    end
  end
  describe '#+' do
    it 'は文法の連結を行い、新しい文法の並びを返します。' do
      (subject + word('news')).parse('hello world news').should == ['hello', 'world', 'news']
    end
  end
  describe '#inspect' do
    it 'は文法の並びをわかりやすい文字列として返します。' do
      subject.inspect.should == '("hello" + "world")'
    end
  end
  describe '#to_s' do
    it 'は文法の並びを文字列として返します。' do
      subject.to_s.should == '("hello" + "world")'
    end
  end
end