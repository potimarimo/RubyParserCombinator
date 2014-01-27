require_relative 'spec_helper'
require 'parsing_expression'

include Rpc
using Support
describe ParsingExpression do
  subject { Word.new 'hello' }
  context '複合的な文法規則' do
    it 'が指定できます。' do
      expr = nil
      value = grammar { token(/[0-9]+/) / (token('(') + expr + ')') }
      product = value + (token('*') / '/' + value).*
      sum = product + (token('+') / '-' + product).*
      expr = sum
      
      expr.parse('1+2').should == ['1', '+', '2']
    end
  end
  describe '#+' do
    it 'は複数の文法の連結を表す文法を生成します。' do
      (subject + Word.new('world')).parse('hello world').should == ['hello', 'world']
    end
    it 'は記号を含まない文字列を受け取り、単語との並びを表す文法を表す文法を生成します。' do
      (subject + 'world').parse('hello world').should == ['hello', 'world']
    end
    it 'は単語以外の文字列を受け取り、トークンとの並びを表す文法を表す文法を生成します。' do
      (subject + '(' + ')').parse('hello()').should == ['hello', '(', ')']
    end
    it 'は正規表現を受け取り、トークンとの並びを表す文法を表す文法を生成します。' do
      (subject + /[0-9]+/).parse('hello 123').should == ['hello', '123']
    end
    it 'は引数をとらずに指定された場合、一回以上の繰り返しを表します。' do
      subject.+.parse('hello hello').should == ['hello', 'hello']
    end
  end
  
  describe '#/' do
    it 'は複数の文法の連結を表す文法を生成します。' do
      (subject / Word.new('world')).parse('world').should == 'world'
    end
    it 'は記号を含まない文字列を受け取り、単語との選択を表す文法を表す文法を生成します。' do
      (subject / 'world').parse('world').should == 'world'
    end
    it 'は単語以外の文字列を受け取り、トークンとの選択を表す文法を表す文法を生成します。' do
      (subject / '(').parse('(').should == '('
    end
    it 'は正規表現を受け取り、トークンとの選択を表す文法を表す文法を生成します。' do
      (subject / /[0-9]+/).parse('123').should == '123'
    end
  end
end