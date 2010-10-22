module Pegarus
  class Character < Pattern
    attr_accessor :string

    def initialize(string)
      @string = string
    end

    def visit(visitor)
      visitor.character self
    end
  end
end
