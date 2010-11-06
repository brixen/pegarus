module Pegarus
  module Machine
    def self.execute(program, subject)
      state = State.new subject
      _, fail = Instructions[:fail]

      total = program.size
      while (ip = state.ip) < total
        break if state.finished? or state.failure?

        width, code = Instructions[program[state.ip]]
        state.next_ip = ip + width

        case width
        when 1
          code[state]
        when 2
          code[state, program[ip+1]]
        when 3
          code[state, program[ip+1], program[ip+2]]
        end

        fail[state] if state.failure?
        state.ip = state.next_ip
      end

      return state.failure? ? nil : state.index
    end
  end
end
