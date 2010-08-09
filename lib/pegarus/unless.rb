module Pegarus
  # Implements !patt in a PEG. The pattern succeeds if
  # patt does not match. Does not consume any input.
  class Unless < UnaryOp
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
