module Pegarus
  module Instructions
    def any(g, count)
      g.push_index
      g.push count
      g.send :+, 1, false

      g.push_subject
      g.send :size, 0, false
      g.send :<=, 1, false
      g.gif g.fail

      g.push count
      g.inc_index
    end

    def char(g, string)
      fail = g.new_label
      done = g.new_label

      g.push_literal string
      g.dup
      g.send :size, 0, false
      g.dup
      g.move_down 2

      g.push_subject
      g.swap
      g.push_index
      g.swap
      g.send :substring, 2, false
      g.send :==, 1, false
      g.gif fail

      g.inc_index
      g.goto done

      fail.set!
      g.pop
      g.goto g.fail

      done.set!
    end
  end
end
