module Pegarus
  module Machine
    module Instructions
      def self.[](opcode)
        instructions[opcode]
      end

      def self.instructions
        @instructions ||= {}
      end

      def self.instruction(name, &block)
        instructions[name] = [block.arity, block]
      end

      instruction :char do |state, char|
        if state.subject[state.index, 1] == char
          state.index += 1
        else
          state.fail
        end
      end

      instruction :jump do |state, label|
      end

      instruction :choice do |state, label|
      end

      instruction :call do |state, label|
      end

      instruction :return do |state|
      end

      instruction :commit do |state, label|
      end

      instruction :capture do |state, data|
      end

      instruction :fail do |state|
      end
    end
  end
end
