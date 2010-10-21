module Pegarus
  class Character < Pattern
    attr_accessor :string

    def initialize(string)
      @string = string
    end
  end
end
