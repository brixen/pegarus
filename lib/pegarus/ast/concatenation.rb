module Pegarus
  class Concatenation < BinaryOp
    def visit(visitor)
      visitor.concatenation self
    end
  end
end
