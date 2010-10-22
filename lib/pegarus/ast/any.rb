module Pegarus
  class Any < Pattern
    attr_accessor :count

    def initialize(count)
      @count = count
    end

    def visit(visitor)
      visitor.any self
    end
  end
end
