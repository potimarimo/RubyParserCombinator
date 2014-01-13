require 'parsing_expression'

class OneOrMore < ParsingExpression
  def initialize(parsing_expression)
    @inner_parsing_expression = parsing_expression
  end
  def inspect
    "(#{@inner_parsing_expression.inspect})+"
  end
  def to_s
    "(#{@inner_parsing_expression})+"
  end
  private
  def really_parse(text)
    if first = @inner_parsing_expression.parse(text)
      result = [first]
      while(second_or_more = @inner_parsing_expression.parse(text))
        result << second_or_more
      end
      result
    end
  end
end