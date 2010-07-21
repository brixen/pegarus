module Pegarus
  class Character < Pattern
    attr_accessor :string

    def initialize(string)
      @string = string
    end

    def bytecode(g)
      char g, @string
    end
  end
end
