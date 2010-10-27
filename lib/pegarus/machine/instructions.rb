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
        if state.subject.getbyte(state.index) == char
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
        state.stack.pop
        state.stack.pop
        state.stack.pop
        state.ip = label
      end

      instruction :capture do |state, data|
        state.captures << state.index << data
      end

      instruction :fail do |state|
        state.failure

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

      # Extended instructions

      instruction :any do |state, count|
        if state.size >= state.index + count
          state.index += count
        else
          state.failure
        end
      end

      instruction :fail_twice do |state|
        state.stack.pop
        state.stack.pop
        state.stack.pop
        state.failure
      end

      instruction :back_commit do |state, label|
        state.failure

        until state.stack.empty?
          item = state.stack.pop
          next unless item.kind_of? Array

          state.captures.replace item
          state.index = state.stack.pop
          state.stack.pop
          state.ip = label

          state.continue
          break
        end
      end
    end
  end
end
