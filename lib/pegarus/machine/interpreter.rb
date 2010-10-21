module Pegarus
  module Machine
    class State
      attr_accessor :ip, :index
      attr_reader :subject, :stack

      def initialize(subject)
        @subject  = subject
        @ip       = 0
        @index    = 0
        @stack    = []
        @fail     = false
      end

      def fail?
        @fail
      end

      def fail
        @fail = true
      end

      def continue
        @fail = false
      end
    end

    def self.execute(program, subject)
      state = State.new subject
      _, fail = Instructions[:fail]

      total = program.size
      while state.ip < total
        width, code = Instructions[program[state.ip]]
        case width
        when 1
          code[state]
        when 2
          code[state, program[state.ip+1]]
        when 3
          code[state, program[state.ip+1], program[state.ip+2]]
        end

        if state.fail?
          fail[state]
        else
          state.ip += width
        end
      end

      return state.fail? ? nil : state.index
    end
  end
end
