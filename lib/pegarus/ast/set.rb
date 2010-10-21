module Pegarus
  class Set < Pattern
    attr_accessor :characters

    def initialize(characters)
      @characters = characters
    end
  end
end
