module Pegarus
  class Any < Pattern
    attr_accessor :count

    def initialize(count)
      @count = count
    end

    def bytecode(g)
      any g, @count
    end
  end
end
