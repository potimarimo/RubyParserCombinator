module Rpc
  class OrderedChoice < ParsingExpression
    def initialize(*parsing_expressions)
      @parsing_expressions = parsing_expressions
    end
    def to_s
      "(#{@parsing_expressions.join(' / ')})"
    end
    alias inspect to_s
    def really_parse(text)
      @parsing_expressions.each do |parsing_expression|
        success, element = parsing_expression.really_parse(text)
        return true, element if success
      end
      return false, nil
    end
    private
    def ordered_choice_new(parsing_expressions)
      OrderedChoice.new(*@parsing_expressions, grammar)
    end
  end
end