class ParsedText
  attr :string
  attr_accessor :index
  def initialize(text)
    @string = text
    @index = 0
  end
  def inspect
    string
  end
  def to_s
    string
  end
  def consumed
    @string[0...index]
  end
  def not_consumed
    @string[index..-1]
  end
end