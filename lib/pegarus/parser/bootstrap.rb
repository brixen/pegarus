module Pegarus
  class BootstrapParser
    include Pegarus

    def initialize(kind)
      @parser = send kind
    end

    def peg
      sp          = pattern([" \t\n"]) * 0
      nonterminal = (pattern("_") / pattern("a".."z") / pattern("A".."Z")) * 1 + sp
      char_class  = (pattern("[") + (-pattern("]") + ((pattern(1) + pattern("-") +
                    pattern(1)) / pattern(1))) * 0) + pattern("]") + sp
      literal     = pattern("'") + (-pattern("'") + pattern(1)) * 0 + pattern("'") + sp
      primary     = (pattern("(") + sp + :pattern + pattern(")") + sp) /
                    (pattern(1) + sp) / literal / char_class / (nonterminal + -pattern("="))
      suffix      = primary + (pattern(["*+?"]) + sp) * 0
      predicate   = pattern(["!&"])
      alternative = ((+predicate + predicate) + sp + suffix) * 1
      pattern     = alternative + (pattern("/") + sp + alternative) * 0
      grammar     = (nonterminal + pattern("=") + sp + pattern) * 1

      Pegarus.grammar :grammar, grammar
    end
  end
end
