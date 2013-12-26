require_relative 'spec_helper'
require 'token'

describe Token do
  subject { Token.new('hello') }
  describe '#to_s' do
    it 'はトークンを文字列として返します。' do
      subject.to_s.should == 'hello'
    end
  end
end