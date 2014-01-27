require 'parsing_expression'

module Rpc
  class AndPredicate < ParsingExpression
    def initialize(parsing_expression)
      @inner_parsing_expression = parsing_expression
    end
    def to_s
      "&#{@inner_parsing_expression}"
    end
    alias inspect to_s
    def really_parse(text)
      index = text.index
      success, element = @inner_parsing_expression.really_parse(text)
      text.index = index
      return success, nil
    end
  end
end