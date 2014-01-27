module Rpc
  class Token < ParsingExpression
    class << self
      alias __new__ new
    end
    def self.new(token)
      obj = 
        case token
        when String
          TokenDefinedAsString.allocate
        when Regexp
          TokenDefinedAsRegexp.allocate
        end
      obj.send(:initialize, token)
      obj
    end
    private
    def check_match(match, text)
      match.begin(0) == text.index
    end
    def action_when_match(regexp, text)
      match = regexp.match(text.string, text.index)
      if match && check_match(match, text)
        text.index += match.to_s.size
        return true, match[1]
      else
        return false, nil
      end
    end
  end

  def token(token_string)
    Token.new(token_string)
  end
end
require 'token_defined_as_string'
require 'token_defined_as_regexp'