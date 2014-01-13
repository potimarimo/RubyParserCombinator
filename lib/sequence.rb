require 'parsing_expression'

class Sequence < ParsingExpression
  def initialize(*grammars)
    @grammars = grammars
  end
  def inspect
    "(#{@grammars.map(&:inspect).join(' + ')})"
  end
  private
  def really_parse(text)
    return_value = []
      @grammars.each do |grammar|
        element = grammar.parse(text)
        if element
          return_value << element
        else
          return
        end
      end
      return_value
  end
  def sequence_new(grammar)
    Sequence.new(*@grammars, grammar)
  end
end