module Pegarus
  class Never < Pattern
    def visit(visitor)
      visitor.never self
    end
  end
end
