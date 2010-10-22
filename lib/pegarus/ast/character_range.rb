module Pegarus
  class CharacterRange < Pattern
    attr_accessor :range

    def initialize(range)
      @range = range
    end

    def visit(visitor)
      visitor.character_range self
    end
  end
end
