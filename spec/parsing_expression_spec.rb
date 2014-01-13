require_relative 'spec_helper'
require 'word'

describe ParsingExpression do
  subject { Word.new 'hello' }
  describe '#+' do
    it 'は複数の文法の連結を表す文法を生成します。' do
      (subject + Word.new('world')).parse('hello world').should == ['hello', 'world']
    end
    it 'は文字列を受け取り、単語と連結された文法を表す文法を生成します。' do
      (subject + 'world').parse('hello world').should == ['hello', 'world']
    end
    it 'は引数をとらずに指定された場合、一回以上の繰り返しを表します。' do
      subject.+.parse('hello hello').should == ['hello', 'hello']
    end
  end
end