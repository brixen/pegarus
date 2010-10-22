module Pegarus
  class Interpreter
    def evaluate(ast)
      visitor = new
      ast.visit visitor
    end

    def always(pattern)
    end

    def any(pattern)
    end

    def any_range(pattern)
    end

    def character(pattern)
    end

    def character_range(pattern)
    end

    def choice(pattern)
    end

    def concatenation(pattern)
    end

    def difference(pattern)
    end

    def if(pattern)
    end

    def never(pattern)
    end

    def product(pattern)
    end

    def set(pattern)
    end

    def unless(pattern)
    end
  end
end
