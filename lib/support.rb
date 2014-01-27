require 'parsing_expression'

module Support
  refine String do
    def +(other)
      case other
      when String, Regexp, ParsingExpression
        Token.new(self) + other
      else
        super
      end
    end
    def /(other)
      case other
      when String, Regexp, ParsingExpression
        Token.new(self) / other
      else
        super
      end
    end
  end
  refine Regexp do
    def +(other)
      case other
      when String, Regexp, ParsingExpression
        Token.new(self) + other
      else
        super
      end
    end
    def /(other)
      case other
      when String, Regexp, ParsingExpression
        Token.new(self) / other
      else
        super
      end
    end
  end
end