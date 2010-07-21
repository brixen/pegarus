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

      g.inc_index count
    end
  end
end
