module Pegarus
  class Evaluator
    def self.new_executor(pattern, subject)
      pattern.instance_variable_set :@evaluator, new

      class << pattern
        class_eval <<-eval
          def match(subject)
            @evaluator.match self, subject
          end
        eval
      end

      pattern.match subject
    end

    def match(pattern, subject)
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

Pegarus::Pattern.select_engine Pegarus::Evaluator
