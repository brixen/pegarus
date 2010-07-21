module Pegarus
  class Concatenation < BinaryOp
    def bytecode(g)
      @first.bytecode(g)
      @second.bytecode(g)
    end
  end
end
