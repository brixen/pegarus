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
    def self.machine(klass)
      include klass
    end

    def graph
      if defined? Rubinius
        Rubinius::AST::AsciiGrapher.new(self, Pattern).print
      else
        inspect
      end
    end

    def visit(visitor)
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
