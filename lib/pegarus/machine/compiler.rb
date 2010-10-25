module Pegarus
  module Machine
    class Compiler
      def compile(pattern)
        program = []
        pattern.instance_variable_set :@program, program

        class << pattern
          class_eval <<-eval
            def match(subject)
              Pegarus::Machine.execute @program, subject
            end
          eval
        end
      end
    end
  end
end
