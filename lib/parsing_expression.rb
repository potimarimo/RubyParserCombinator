module Rpc
  class ParsingExpression
    def parse(text)
      case text
      when String
        parse(ParsedText.new(text))
      when ParsedText
        success, result = really_parse(text)
        result
      end
    end
    def +(parsing_expression = nil)
      if parsing_expression
        sequence_new to_parsing_expression(parsing_expression)
      else
        OneOrMore.new(self)
      end
    end
    def /(parsing_expression)
      ordered_choice_new(to_parsing_expression(parsing_expression))
    end
    def &
      AndPredicate.new(self)
    end
    def !
      NotPredicate.new(self)
    end
    def *(range = nil)
      if range
        Repeat.new(self, range)
      else
        ZeroOrMore.new(self)
      end
    end
    def -
      Optional.new(self)
    end
    private
    def sequence_new(parsing_expression)
      Sequence.new self, parsing_expression
    end
    def ordered_choice_new(parsing_expression)
      OrderedChoice.new self, parsing_expression
    end
    def to_parsing_expression(obj)
      case obj
      when String
        Token.new(obj)
      when Regexp
        Token.new(obj)
      else
        obj
      end
    end
  end
end

require 'word'
require 'token'
require 'sequence'
require 'ordered_choice'
require 'repeat'
require 'one_or_more'
require 'zero_or_more'
require 'optional'
require 'and_predicate'
require 'not_predicate'
require 'start_of_text'
require 'end_of_text'
require 'grammar'
require 'support'