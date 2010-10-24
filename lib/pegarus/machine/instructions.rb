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
        if state.subject[state.index] == char
          state.index += 1
        else
          state.failure
        end
      end

      instruction :jump do |state, label|
        state.ip = label
      end

      instruction :choice do |state, label|
        state.stack << label << state.index << state.captures.dup
      end

      instruction :call do |state, label|
        state.stack << state.ip + 2
        state.ip = label
      end

      instruction :return do |state|
        state.ip = state.stack.pop
      end

      instruction :commit do |state, label|
        state.stack[-3..-1] = nil
        state.ip = label
      end

      instruction :capture do |state, data|
        state.captures << [state.index, data]
      end

      instruction :fail do |state|
        until state.stack.empty?
          item = state.stack.pop
          next unless item.kind_of? Array

          state.captures.replace item
          state.index = state.stack.pop
          state.ip = state.stack.pop

          state.continue
          break
        end
      end
    end
  end
end
