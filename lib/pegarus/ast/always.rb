module Pegarus
  class Always < Pattern
    def visit(visitor)
      visitor.always self
    end
  end
end
