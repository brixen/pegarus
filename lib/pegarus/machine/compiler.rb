module Pegarus
  module Machine
    class Compiler
      attr_reader :g

      def initialize
        @g = Generator.new
      end

      def compile(pattern)
        pattern.visit self
        pattern.instance_variable_set :@program, g.program

        class << pattern
          class_eval <<-eval
            def match(subject)
              Pegarus::Machine.execute @program, subject
            end
          eval
        end
      end

      def always(pattern)
        g.fail
      end

      def any(pattern)
        g.any pattern.count
      end

      def any_range(pattern)
        g.fail
      end

      def character(pattern)
        pattern.string.each_byte { |b| g.char b }
      end

      def character_range(pattern)
        g.fail
      end

      def choice(pattern)
        fail = g.new_label
        pass = g.new_label

        g.choice fail
        pattern.first.visit self
        g.commit pass

        fail.set!
        pattern.second.visit self

        pass.set!
      end

      def concatenation(pattern)
        pattern.first.visit self
        pattern.second.visit self
      end

      def difference(pattern)
        g.fail
      end

      def if(pattern)
        fail = g.new_label
        pass = g.new_label

        g.choice fail
        pattern.pattern.visit self
        g.back_commit pass

        fail.set!
        g.fail

        pass.set!
      end

      def never(pattern)
        g.fail
      end

      def product(pattern)
        g.fail
      end

      def set(pattern)
        g.fail
      end

      def unless(pattern)
        lbl = g.new_label
        g.choice lbl
        pattern.pattern.visit self
        g.fail_twice
        lbl.set!
      end
    end
  end
end
