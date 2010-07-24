module Pegarus
  def pattern(spec)
    case spec
    when Array
      Set.new spec.join
    when Integer
      Any.new spec
    when String
      Character.new spec
    when Range
      case spec.first
      when Integer
        AnyRange.new spec
      when String
        CharacterRange.new spec
      end
    when Symbol
      variable spec
    when Pattern
      spec
    when true
      Always.new
    when false
      Never.new
    when nil
      nil
    else
      raise ParseError, "unknown specification type for Pattern: #{spec.inspect}"
    end
  end
  module_function :pattern

  class Pattern
    include Instructions

    def match(subject)
      compile subject
    end

    def compile(subject)
      g = Generator.new

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

      bytecode(g)
      finish(g)

      g.encode Rubinius::InstructionSequence::Encoder
      cm = g.package Rubinius::CompiledMethod
      puts cm.decode if $DEBUG

      ss = Rubinius::StaticScope.new Object
      Rubinius.attach_method :match, cm, ss, self

      match subject
    end

    def bytecode(g)
      g.push :nil
      g.goto g.fail
    end

    def finish(g)
      # end
      g.push_index
      g.goto g.done

      # fail
      g.fail.set!
      g.push :nil

      g.done.set!
      g.ret
      g.close
    end

    def graph
      Rubinius::AST::AsciiGrapher.new(self, Pattern).print
    end

    # Pattern operators

    def /(other)
      Choice.new self, other
    end

    def +(other)
      Concatenation.new self, other
    end

    def -(other)
      Difference.new self, other
    end

    def *(other)
      Product.new self, other
    end

    def +@
      If.new self
    end

    def -@
      Unless.new self
    end
  end

  class UnaryOp < Pattern
    attr_accessor :pattern

    def initialize(pattern)
      @pattern = Pegarus.pattern pattern
    end
  end

  class BinaryOp < Pattern
    attr_accessor :first, :second

    def initialize(first, second)
      @first = Pegarus.pattern first
      @second = Pegarus.pattern second
    end
  end
end
