class Sign < ParsingExpression
  def initialize(sign_string)
    @sign_string = sign_string
  end
  def inspect
    "\"#@sign_string\""
  end
  def to_s
    @sign_string
  end
  def really_parse(text)
    if match = /\s*#@sign_string\s*/.match(text.string, text.index)
      text.index += match.to_s.size
      return true, @sign_string
    else
      return false, nil
    end
  end
end

def sign(sign_string)
  Sign.new(sign_string)
end