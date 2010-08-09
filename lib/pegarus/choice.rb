module Pegarus
  class Choice < BinaryOp
    def bytecode(g)
      g.push_index # store index, so that we can restart
      old_fail = g.fail
      done = g.new_label

      choice_fail = g.new_label
      g.fail = choice_fail
      @first.bytecode(g)
      g.pop # success, pop index
      g.fail = old_fail # reset fail
      g.goto done

      choice_fail.set!
      g.fail = old_fail
      g.set_index # reset index to the stored index, this pops the value
      @second.bytecode(g)

      done.set!
    end
  end
end
