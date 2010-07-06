module Pegarus
  class AnyRange < Pattern
    attr_accessor :range

    def initialize(range)
      @range = range
    end
  end
end
