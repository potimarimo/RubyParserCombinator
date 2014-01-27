require 'parsing_expression'

module Rpc
  class Optional < Repeat
    def initialize(parsing_expression)
      super(parsing_expression, 0..1)
    end
    def to_s
      "#{@inner_parsing_expression}-"
    end
    alias inspect to_s
    def really_parse(text)
      success, element = super
      return true, element[0]
    end
  end
end
