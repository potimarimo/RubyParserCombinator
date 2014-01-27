require 'token'
module Rpc
  class TokenDefinedAsString < Token
    def initialize(token)
      @token_string = token
    end
    def to_s
      "\"#@token_string\""
    end
    alias inspect to_s
    def really_parse(text)
      action_when_match(/\s*(#{Regexp.escape(@token_string)})\s*/, text)
    end
  end
end