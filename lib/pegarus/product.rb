module Pegarus
  class Product < BinaryOp
    def initialize(first, second)
      @first = Pegarus.pattern first
      @second = Type.coerce_to second, Integer, :to_int
    end
  end
end
