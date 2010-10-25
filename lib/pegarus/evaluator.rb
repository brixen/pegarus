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
      @subject  = subject
      @failure  = false
      @index    = 0

      pattern.visit self

      failure? ? nil : @index
    end

    def failure
      @failure = true
    end

    def failure?
      @failure
    end

    def always(pattern)
      failure
    end

    def any(pattern)
      if @subject.size > @index + pattern.count
        @index += pattern.count
      else
        failure
      end
    end

    def any_range(pattern)
      failure
    end

    def character(pattern)
      failure
    end

    def character_range(pattern)
      failure
    end

    def choice(pattern)
      failure
    end

    def concatenation(pattern)
      failure
    end

    def difference(pattern)
      failure
    end

    def if(pattern)
      failure
    end

    def never(pattern)
      failure
    end

    def product(pattern)
      failure
    end

    def set(pattern)
      failure
    end

    def unless(pattern)
      failure
    end
  end
end

Pegarus::Pattern.select_engine Pegarus::Evaluator
