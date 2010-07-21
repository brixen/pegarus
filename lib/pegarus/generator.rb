module Pegarus
  class Generator < Rubinius::Generator
    attr_reader :fail, :done

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

    def set_index(n)
      push n
      set_local 1
    end

    def inc_index(n=1)
      push_local 1
      push n
      send :+, 1, false
      set_local 1
      pop
    end
  end
end
