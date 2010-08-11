module Pegarus
  class Any < Pattern
    attr_accessor :count

    def initialize(count)
      @count = count
    end
  end
end
