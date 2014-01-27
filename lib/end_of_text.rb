require 'parsing_expression'

module Rpc
  class EndOfText < ParsingExpression
    def to_s
      'end'
    end
    alias inspect to_s
    def really_parse(text)
      text.index == text.string.size
    end
  end

  def end_of_text
    EndOfText.new
  end
end