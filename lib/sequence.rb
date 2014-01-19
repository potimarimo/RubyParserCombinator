require 'parsing_expression'

class Sequence < ParsingExpression
  def initialize(*grammars)
    @grammars = grammars
  end
  def inspect
    "(#{@grammars.map(&:inspect).join(' + ')})"
  end
  def really_parse(text)
    return_value = []
      @grammars.each do |grammar|
        success, element = grammar.really_parse(text)
        if success
          return_value << element
        else
          return false, nil
        end
      end
      return true, return_value
  end
  def sequence_new(grammar)
    Sequence.new(*@grammars, grammar)
  end
end