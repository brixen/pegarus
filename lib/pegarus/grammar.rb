module Pegarus
  def grammar(spec=nil, pattern=nil)
    case spec
    when Symbol
      Grammar.new Variable.new(spec, pattern)
    when Variable
      Grammar.new spec
    when Pattern
      Grammar.new Variable.new(:S, spec)
    when nil
      Grammar.new
    else
      Grammar.new Variable.new(:S, pattern)
    end
  end
  module_function :grammar

  class Grammar < Pattern
    attr_accessor :start

    def initialize(variable=nil)
      if variable
        @start = variable.name
        set_variable variable.name, variable.pattern
      end
    end

    def set_variable(name, *pattern)
      variable = get_variable name
      variable.pattern = *pattern
      variable
    end

    def get_variable(name)
      if metaclass.method_defined? name
        variable = send name
      else
        vname = name.to_sym
        variable = Variable.new vname
        metaclass.thunk_method vname, variable
      end

      variable
    end

    def method_missing(sym, *args)
      name = sym.to_s

      if name[-1] == ?=
        set_variable name[0..-2], *args
      else
        get_variable name
      end
    end
  end
end
