require 'parsing_expression'
module Rpc
  class Sequence < ParsingExpression
    def initialize(*parsing_expressions)
      @parsing_expressions = parsing_expressions
    end
    def to_s
      "(#{@parsing_expressions.join(' + ')})"
    end
    alias inspect to_s
    def really_parse(text)
      return_value = []
      index = text.index
      @parsing_expressions.each do |parsing_expression|
        success, element = parsing_expression.really_parse(text)
        if success
          case 
          when element.nil?
          when (OneOrMore === parsing_expression || ZeroOrMore === parsing_expression) && element.respond_to?(:each)
            return_value +=
              element.inject([]) do |memo, item|
                case item
                when Array
                  memo += item
                else
                  memo << item
                end
              end
          when Sequence === parsing_expression
            case element.size
            when 0
            when 1
              return_value << element.first
            else
              return_value += element
            end
          else
            return_value << element
          end
        else
          text.index = index
          return false, nil
        end
      end
      return true, return_value
    end
    private
    def sequence_new(parsing_expression)
      Sequence.new(*@parsing_expressions, parsing_expression)
    end
  end
end