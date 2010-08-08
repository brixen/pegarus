module Pegarus
  # Implements &patt in a PEG. The pattern succeeds if
  # patt matches. Does not consume any input.
  class If < UnaryOp
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
end
