module Pegarus
  class Difference < BinaryOp
    def visit(visitor)
      visitor.difference self
    end
  end
end
