module Rpc
  class Grammar < ParsingExpression
    def initialize(&block)
      @block = block
    end
    def really_parse(text)
      @block.call().really_parse(text)
    end
  end

  def grammar(&block)
    Grammar.new(&block)
  end
end