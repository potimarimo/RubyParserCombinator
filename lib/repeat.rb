module Rpc
  class Repeat< ParsingExpression
    def initialize(parsing_expression, range)
      @inner_parsing_expression = parsing_expression
      @range = range
    end
    def really_parse(text)
      result = []
      index = text.index
      1.upto(@range.first).each do
        success, element = @inner_parsing_expression.really_parse(text)
        if success
          result << element
        else
          text.index = index
          return false, nil
        end
      end
      1.upto(@range.last - @range.first).each do
        success, element = @inner_parsing_expression.really_parse(text)
        if success
          result << element
        else
          break
        end
      end
      return true, result
    end
  end
end