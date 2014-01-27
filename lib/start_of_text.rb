require 'parsing_expression'

module Rpc
  class StartOfText < ParsingExpression
    def to_s
      'start'
    end
    alias inspect to_s
    def really_parse(text)
      text.index == 0
    end
  end

  def start_of_text
    StartOfText.new
  end
end