module Pegarus
  module ParsingMachine
    class VM
      attr_reader :pc, :index, :stack

      def initialize(pattern)
        @program = Compiler.new(pattern).compile
      end

      def reset
        @pc = 0
        @index = 0
        @stack = []
      end

      def execute(subject)
        reset

        last = @program.size

        while @pc < last
          case @program[@pc]
          # no-op
          when 0

          # char
          when 1

          end

          @pc += 1
        end
      end
    end
  end
end
