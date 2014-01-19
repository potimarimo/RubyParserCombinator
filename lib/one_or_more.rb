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
  def really_parse(text)
    success, first = @inner_parsing_expression.really_parse(text)
    if success
      result = [first]
      success, second_or_more = @inner_parsing_expression.really_parse(text)
      while success
        result << second_or_more
        success, second_or_more = @inner_parsing_expression.really_parse(text)
      end
      return true, result
    else
      return false, nil
    end
  end
end