module Pegarus
  class Set < Pattern
    attr_accessor :set

    def initialize(set)
      @set = set.uniq
    end

    def visit(visitor)
      visitor.set self
    end
  end
end
