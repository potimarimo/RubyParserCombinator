class ParsingExpression
  def parse(text)
    case text
    when String
      parse(ParsedText.new(text))
    when ParsedText
      really_parse(text)
    end
  end
  def +(parsing_expression = nil)
    if parsing_expression
      parsing_expression = Word.new(parsing_expression) if String === parsing_expression
      sequence_new(parsing_expression)
    else
      OneOrMore.new(self)
    end
  end
  private 
  def sequence_new(parsing_expression)
    Sequence.new self, parsing_expression
  end
end


require 'word'
require 'sign'
require 'sequence'
require 'one_or_more'