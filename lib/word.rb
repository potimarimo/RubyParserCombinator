require 'token'
module Rpc
  class Word < Token
    class << self
      alias new __new__
    end
    
    def initialize(word_string)
      @word_string = word_string
    end
    def to_s
      "\"#@word_string\""
    end
    alias inspect to_s
    def really_parse(text)
      action_when_match(/\s*(\w+)\s*/, text)
    end
    def check_match(match, text)
       match[1] == @word_string
    end
  end

  def word(word_string)
    Word.new(word_string)
  end
end
