module Pegarus
  class AnyRange < Pattern
    attr_accessor :range

    def initialize(range)
      @range = range
    end

    def visit(visitor)
      visitor.any_range self
    end
  end
end
