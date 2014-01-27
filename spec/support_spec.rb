require_relative 'spec_helper'
require 'parsing_expression'

include Rpc
using Support
describe Support do
  describe 'String+String' do
    it 'はトークンの連結を生成します。' do
      ("(" + ")").parse("()").should == ["(", ")"]
    end
  end
  describe 'String/String' do
    it 'はトークンの選択を生成します。' do
      ("(" / ")").parse(")").should == ")"
    end
  end
  describe 'Regexp+String' do
    it 'はトークンの連結を生成します。' do
      (/\d+/ + ")").parse("123)").should == ["123", ")"]
    end
  end
  describe 'Regexp/String' do
    it 'はトークンの選択を生成します。' do
      (/\d+/ / ")").parse("123").should == "123"
    end
  end
    describe 'String+Regexp' do
    it 'はトークンの連結を生成します。' do
      ("(" + /\d+/).parse("(123").should == ["(", "123"]
    end
  end
  describe 'String/Regexp' do
    it 'はトークンの選択を生成します。' do
      ("(" / /\d+/).parse("123").should == "123"
    end
  end
  describe 'Regexp+Regexp' do
    it 'はトークンの連結を生成します。' do
      (/\d+/ + /\D+/).parse("123abc").should == ["123", "abc"]
    end
  end
  describe 'Regexp/Regexp' do
    it 'はトークンの選択を生成します。' do
      (/\d+/ / /\D+/).parse("abc").should == "abc"
    end
  end
  describe 'String+ParsingExpression' do
    it 'はトークンの連結を生成します。' do
      ("(" + token('123')).parse("(123").should == ["(", "123"]
    end
  end
  describe 'String/ParsingExpression' do
    it 'はトークンの選択を生成します。' do
      ("(" / token('123')).parse("123").should == "123"
    end
  end
  describe 'Regexp+ParsingExpression' do
    it 'はトークンの連結を生成します。' do
      (/\d+/ + token('abc')).parse("123abc").should == ["123", "abc"]
    end
  end
  describe 'Regexp/ParsingExpression' do
    it 'はトークンの選択を生成します。' do
      (/\d+/ / token('abc')).parse("abc").should == "abc"
    end
  end
  context '複合的な文法規則' do
    it 'が指定できます。' do
      expr = nil
      value = grammar { /[0-9]+/ / ('(' + expr + ')') }
      product = value + ('*' / '/' + value).*
      sum = product + ('+' / '-' + product).*
      expr = sum
      
      expr.parse('(11+22)*(33-44)').should == [["(", "11", "+", "22", ")"], "*", ["(", "33", "-", "44", ")"]]
    end
  end
end