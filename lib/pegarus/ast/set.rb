module Pegarus
  class Set < Pattern
    attr_accessor :characters

    def initialize(characters)
      @characters = characters
    end

    def visit(visitor)
      visitor.set self
    end
  end
end
