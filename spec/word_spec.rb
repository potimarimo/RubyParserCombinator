require_relative 'spec_helper'
require 'word'

include Rpc
describe Word do
  subject { Word.new 'hello' }
  
  describe 'word' do
    it 'でWordを生成できます。' do
      word('hello').should be_an_instance_of Word
    end
    it 'で単語を指定できます。' do
      word('hello').to_s.should == '"hello"'
    end
  end
  
  describe '#inspect' do
    it 'は単語をダブルクォーテーションで囲ったものを返します。' do
      subject.inspect.should == '"hello"'
    end
  end
  
  describe '#to_s' do
    it 'は単語をダブルクォーテーションで囲ったものを返します。' do
      subject.to_s.should == '"hello"'
    end
  end
  
  describe '#parse' do
    it 'は単語を認識します。' do
      subject.parse('hello').should == 'hello'
    end
    it 'は認識した単語の分、文字列を消費します。' do
      text = ParsedText.new('hello')
      subject.parse(text)
      text.consumed.should == 'hello'
    end
    it 'は単語の後のスペースを含め、文字列を消費します。' do
      text = ParsedText.new('hello  ')
      subject.parse(text)
      text.consumed.should == 'hello  '
    end
    it 'は単語の前のスペースを含め、文字列を消費します。' do
      text = ParsedText.new('  hello')
      subject.parse(text)
      text.consumed.should == '  hello'
    end
    it 'は連続して利用できます。' do
        (subject + Word.new('world')).parse('hello world').should == ['hello', 'world']
      end
    it 'は指定の単語以外が指定された場合に、nilを返します。' do
      subject.parse('apple').should be_nil
    end
    it 'は指定の単語の後に文字列が続くテキストが指定された場合に、nilを返します。' do
      subject.parse('helloo').should be_nil
    end
    it 'は指定の単語の前に文字列が続くテキストが指定された場合に、nilを返します。' do
      subject.parse('hhello').should be_nil
    end
    context 'は先頭' do
      it 'のスペースを認識しません。' do
        subject.parse(' hello').should == 'hello'
      end
      it 'のタブを認識しません。' do
        subject.parse('	hello').should == 'hello'
      end
      it 'の\rを認識しません。' do
        subject.parse("\rhello").should == 'hello'
      end
      it 'の\nを認識しません。' do
        subject.parse("\nhello").should == 'hello'
      end
      it 'の複数の空白を認識しません。' do
        subject.parse(" 	\r\nhello").should == 'hello'
      end
    end
    context 'は末尾' do
      it 'のスペースを認識しません。' do
        subject.parse('hello ').should == 'hello'
      end
      it 'のタブを認識しません。' do
        subject.parse('hello	').should == 'hello'
      end
      it 'の\rを認識しません。' do
        subject.parse("hello\r").should == 'hello'
      end
      it 'の\nを認識しません。' do
        subject.parse("hello\n").should == 'hello'
      end
      it 'の複数の空白を認識しません。' do
        subject.parse("hello\r\n	 ").should == 'hello'
      end
    end
  end
end