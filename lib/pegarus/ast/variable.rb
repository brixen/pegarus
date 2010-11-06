module Pegarus
  def variable(name, pattern=nil)
    Pegarus::Variable.new name, pattern
  end
  module_function :variable

  class Variable < Pattern
    attr_accessor :name, :pattern

    def initialize(name, pattern=nil)
      @name = name.to_sym
      @pattern = Pegarus.pattern pattern
    end

    def visit(visitor)
      visitor.variable self
    end
  end
end
