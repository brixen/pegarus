module Pegarus
  class Product < Pattern
    attr_accessor :pattern, :count

    def initialize(pattern, count)
      @pattern = Pegarus.pattern pattern
      @count = Type.coerce_to count, Integer, :to_int
    end

    def visit(visitor)
      visitor.product self
    end
  end
end
