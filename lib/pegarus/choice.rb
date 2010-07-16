module Pegarus
  class Choice < Pattern
    attr_accessor :first, :second

    def initialize(first, second)
      @first = Pegarus.pattern first
      @second = Pegarus.pattern second
    end
  end
end
