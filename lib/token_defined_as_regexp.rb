require 'token'
module Rpc
  class TokenDefinedAsRegexp < Token
    def initialize(token)
      @token_regexp = token
    end
    def to_s
      "/#{@token_regexp.source}/" 
    end
    alias inspect to_s
    def really_parse(text)
      action_when_match(/\s*(#{@token_regexp.source})\s*/, text)
    end
  end
end