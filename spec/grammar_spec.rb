require_relative 'spec_helper'
require 'parsing_expression'

include Rpc
describe Grammar do
  subject { Grammar.new {Word.new('hello')} }
  it 'は指定したブロックが生成する規則と同じパースを行います。' do
    subject.parse('hello').should == 'hello'
  end
  describe 'grammar' do
    subject {grammar { word('hello') }}
    it 'でRecursivelyが生成できます。' do
      should be_an_instance_of Grammar
    end
    it 'で生成した文法は正しく動作します。' do
      subject.parse('hello').should == 'hello'
    end
    it 'を利用した場合に再帰的な定義が可能となります。' do
      x = grammar { token('/') + x / end_of_text }
      x.parse('/////').should == ['/', ['/', ['/', ['/', ['/']]]]]
    end
  end
end