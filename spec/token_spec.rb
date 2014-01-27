require_relative 'spec_helper'
require 'token'

include Rpc
describe Token do
  subject { token('=') }
  describe 'token' do
    it 'はTokenを生成できます。' do
      token('+').parse('+').should == '+'
    end
  end
  describe '#inspect' do
    it 'は記号をダブルクォーテーションで囲ったものを返します。' do
      subject.inspect.should == '"="'
    end
    it 'は正規表現で指定された場合に正規表現リテラルを返します。' do
      Token.new(/abc/).inspect.should == '/abc/'
    end
  end
  describe '#to_s' do
    it 'は記号をダブルクォーテーションで囲ったものを返します。' do
      subject.to_s.should == '"="'
    end
    it 'は正規表現で指定された場合に正規表現リテラルを返します。' do
      Token.new(/abc/).to_s.should == '/abc/'
    end
  end
  describe '#parse' do
    it 'は記号を認識します' do
      subject.parse('=').should == '='
    end
    it 'は正規表現でも指定できます' do
      token(/[0-9]+/).parse('123').should == '123'
    end
    it 'は連続して利用できます' do
      (token('+') + subject).parse('+=').should == ['+', '=']
    end
    it 'は指定した以外の記号の場合は認識に失敗します。' do
      subject.parse('/').should be_nil
    end
    it 'は正規表現での指定で現在読み込んでいる位置以外でのマッチは失敗します。' do
      (token('(') + /[0-9]+/).parse('((123').should be_nil
    end
    it 'は認識した記号の分、文字列を消費します。' do
      text = ParsedText.new('==')
      subject.parse(text)
      text.consumed.should == '='
    end
    it 'は前のスペースを含め、文字列を消費します。' do
      text = ParsedText.new(' =')
      subject.parse(text)
      text.consumed.should == ' ='
    end
    it 'は後のスペースを含め、文字列を消費します。' do
      text = ParsedText.new('= ')
      subject.parse(text)
      text.consumed.should == '= '
    end
    it 'は記号の後に文字列が続いていても、識別を行います。' do
      text = ParsedText.new('=a')
      subject.parse(text)
      text.consumed.should == '='
    end
  end
  describe '#+' do
    it 'は複数の条件を表す文法を生成します。' do
      (subject + subject).parse('==').should == ['=', '=']
    end
  end
end