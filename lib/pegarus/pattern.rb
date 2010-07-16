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
    def match(subject)
      # every pattern is the root of a tree
      # setup (and equiv of 'S / . S') then call #bytecode(g)
    end

    def /(other)
      Choice.new self, other
    end

    def +(other)
      Concatenation.new self, other
    end

    def +@
      If.new self
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
