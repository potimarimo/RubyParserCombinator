module Rpc
  class ParsedText
    attr :string
    attr_accessor :index
    def initialize(text_string)
      @string = text_string
      @index = 0
    end
    def inspect
      "#{consumed}|#{not_consumed}"
    end
    alias to_s string
    def consumed
      @string[0...index]
    end
    def not_consumed
      @string[index..-1]
    end
  end
end