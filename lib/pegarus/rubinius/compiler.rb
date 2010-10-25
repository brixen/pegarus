module Pegarus
  module Rubinius
    def self.new_executor(pattern, subject)
      Compiler.new.compile pattern
      pattern.match subject
    end

    class Compiler
      attr_reader :g

      def initialize
        @g = Generator.new
      end

      def compile(pattern)
        g.name = :match
        g.file = :"(pegarus)"
        g.set_line 1

        g.required_args = 1
        g.total_args = 1
        g.splat_index = nil

        g.local_count = 2
        g.local_names = [:subject, :index]

        g.push 0
        g.set_index

        pattern.visit self
        g.finish

        g.encode
        cm = g.package ::Rubinius::CompiledMethod
        puts cm.decode if $DEBUG

        ss = ::Rubinius::StaticScope.new Object
        ::Rubinius.attach_method :match, cm, ss, pattern
      end

      def failure
        g.push :nil
        g.goto g.fail
      end

      def always(pattern)
        failure
      end

      def any(pattern)
        failure
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

      def set(pattern)
        failure
      end

      def unless(pattern)
        failure
      end
    end

    def any(g, count)
      g.push_index
      g.push count
      g.send :+, 1, false

      g.push_subject
      g.send :size, 0, false
      g.send :<=, 1, false
      g.gif g.fail

      g.push count
      g.inc_index
    end

    def char(g, string)
      fail = g.new_label
      done = g.new_label

      g.push_literal string
      g.dup
      g.send :size, 0, false
      g.dup
      g.move_down 2

      g.push_subject
      g.swap
      g.push_index
      g.swap
      g.send :substring, 2, false
      g.send :==, 1, false
      g.gif fail

      g.inc_index
      g.goto done

      fail.set!
      g.pop
      g.goto g.fail

      done.set!
    end
  end

  class Any
    def bytecode(g)
      any g, @count
    end
  end

  class Character
    def bytecode(g)
      char g, @string
    end
  end

  class Choice
    def bytecode(g)
      g.push_index # store index, so that we can restart
      old_fail = g.fail
      done = g.new_label

      choice_fail = g.new_label
      g.fail = choice_fail
      @first.bytecode(g)
      g.pop # success, pop index
      g.fail = old_fail # reset fail
      g.goto done

      choice_fail.set!
      g.fail = old_fail
      g.set_index # reset index to the stored index, this pops the value
      @second.bytecode(g)

      done.set!
    end
  end

  class Concatenation
    def bytecode(g)
      @first.bytecode(g)
      @second.bytecode(g)
    end
  end

  class If
    def bytecode(g)
      g.push_index # store index, so that we can restart
      old_fail = g.fail
      done = g.new_label

      pattern_fail = g.new_label
      g.fail = pattern_fail
      @pattern.bytecode(g)
      # success
      g.set_index #  reset index to the stored index, this pops the value
      g.fail = old_fail # reset fail
      g.goto done
      # failure
      pattern_fail.set!
      g.set_index # reset index to the stored index, this pops the value
      g.fail = old_fail
      g.goto g.fail

      done.set!
    end
  end

  class Unless
    def bytecode(g)
      g.push_index # store index, so that we can restart
      old_fail = g.fail

      pattern_fail = g.new_label
      g.fail = pattern_fail
      @pattern.bytecode(g)
      # success => failure
      g.set_index #  reset index to the stored index, this pops the value
      g.fail = old_fail # reset fail
      g.goto g.fail
      # failure => success
      pattern_fail.set!
      g.set_index # reset index to the stored index, this pops the value
      g.fail = old_fail
    end
  end
end
