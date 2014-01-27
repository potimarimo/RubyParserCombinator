require 'parsing_expression'
module Rpc
  class ZeroOrMore < Repeat
    def initialize(parsing_expression)
      super(parsing_expression, 0..Float::INFINITY)
    end
    def to_s
      "#{@inner_parsing_expression}*"
    end
    alias inspect to_s
  end
end