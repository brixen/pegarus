module Pegarus
  module ParsingMachine
    class VM
      def self.execute(program, subject)
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
