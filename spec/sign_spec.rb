require_relative 'spec_helper'
require 'sign'

describe Sign do
  subject { Sign.new '=' }
  describe 'sign' do
    it 'はSignを生成できます。' do
      sign('+').parse('+').should == '+'
    end
  end
  describe '#inspect' do
    it 'は記号をダブルクォーテーションで囲ったものを返します。' do
      subject.inspect.should == '"="'
    end
  end
  describe '#to_s' do
    it 'は記号をそのまま返します。' do
      subject.to_s.should == '='
    end
  end
  describe '#parse' do
    it 'は記号を認識します' do
      subject.parse('=').should == '='
    end
    it 'は連続して利用できます' do
      (sign('+') + subject).parse('+=').should == ['+', '=']
    end
    it 'は指定した以外の記号の場合は認識に失敗します。' do
      subject.parse('/').should be_nil
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