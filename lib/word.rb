require 'parsed_text'
require 'parsing_expression'

class Word < ParsingExpression
  def initialize(word_string)
    @word_string = word_string
  end
  
  def inspect
    "\"#@word_string\""
  end
  
  def to_s
  	@word_string
  end
  
  private
  def really_parse(text)
    result = /\s*(\w+)\s*/.match(text.string, text.index)
      if result && result[1] == @word_string
        text.index += result.to_s.size
        @word_string
      end
  end
end

def word(word_string)
  Word.new(word_string)
end
