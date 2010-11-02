module Pegarus
  # Accepts a Ruby object representation of simple PEG "atoms" and returns an
  # AST node.
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
      raise InvalidPatternError, "unknown specification type for Pattern: #{spec.inspect}"
    end
  end
  module_function :pattern


  # Class Pattern is the base class for all nodes used to represent the AST
  # for a PEG. Following LPEG, the base is a pattern and not a grammar.
  class Pattern
    # Executes the PEG pattern on subject. If the pattern matches a prefix of
    # subject, returns the index one character past the last matching
    # character. Otherwise, returns nil.
    #
    # The pattern AST is purely a representation. By default, it includes no
    # machinery to execute the pattern over the subject. All execution is
    # provided by other facilities, for example, the AST evaluator and the
    # parsing machine compiler and interpreter. These facilities are called
    # "engines".
    #
    # The Pattern class defaults to the AST Evaluator engine. The protocol
    # requires the engine class to respond to .new_exector taking the AST root
    # node and the subject as arguments. The default Pattern#match method is
    # essentially a trampoline. It calls new_executor and expects that method
    # to replace #match on the root node and then tail call to the new #match
    # method installed by the engine.

    def match(subject)
      Pattern.engine.new_executor self, subject
    end

    def self.engine
      unless @engine
        require 'pegarus/evaluator'
        @engine = Evaluator
      end

      @engine
    end

    def self.select_engine(klass)
      @engine = klass
    end

    def graph
      if defined? Rubinius
        Rubinius::AST::AsciiGrapher.new(self, Pattern).print
      else
        inspect
      end
      nil
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
