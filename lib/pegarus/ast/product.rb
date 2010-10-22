module Pegarus
  class Product < BinaryOp
    def initialize(first, second)
      @first = Pegarus.pattern first
      @second = Type.coerce_to second, Integer, :to_int
    end

    def visit(visitor)
      visitor.product self
    end
  end
end
