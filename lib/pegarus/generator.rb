module Pegarus
  class Generator < Rubinius::Generator
    attr_reader :done 
    attr_accessor :fail

    def initialize
      super
      @fail = new_label
      @done = new_label
    end

    def push_subject
      push_local 0
    end

    def push_index
      push_local 1
    end

    def set_index
      set_local 1
      pop
    end

    def inc_index
      push_local 1
      send :+, 1, false
      set_local 1
      pop
    end
  end
end
