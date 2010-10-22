module Pegarus
  class Choice < BinaryOp
    def visit(visitor)
      visitor.choice self
    end
  end
end
