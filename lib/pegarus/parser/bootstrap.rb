module Pegarus
  class BootstrapParser
    include Pegarus

    def initialize(kind)
      @parser = send kind
    end

    def peg
      g = grammar   = grammar(:grammar)
      g.grammar     = (g.nonterminal + "=" + g.sp + g.pattern) * 1
      g.pattern     = g.alternative + (pattern("/") + g.sp + g.alternative) * 0
      g.alternative = ((+g.predicate + g.predicate) + g.sp + g.suffix) * 1
      g.predicate   = ["!&"]
      g.suffix      = g.primary + (pattern(["*+?"]) + g.sp) * 0
      g.primary     = (pattern("(") + g.sp + g.pattern + ")" + g.sp) / (pattern(1) + g.sp) /
                      g.literal / g.char_class / (g.nonterminal + -pattern("="))
      g.literal     = pattern("'") + (-pattern("'") + 1) * 0 + "'" + g.sp
      g.char_class  = (pattern("[") + (-pattern("]") +
                      ((pattern(1) + "-" + 1) / 1)) * 0) + "]" + g.sp
      g.nonterminal = (pattern("_") / ["a".."z"] / ["A".."Z"]) * 1 + g.sp
      g.sp          = pattern([" \t\n"]) * 0

      grammar
    end
  end
end
