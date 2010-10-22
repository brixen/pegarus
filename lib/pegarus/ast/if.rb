module Pegarus
  # Implements &patt in a PEG. The pattern succeeds if
  # patt matches. Does not consume any input.
  class If < UnaryOp
    def visit(visitor)
      visitor.if self
    end
  end
end
