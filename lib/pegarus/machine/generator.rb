module Pegarus
  module Machine
    class Generator
      attr_reader :program

      def initialize
        @program = []
      end

      def method_missing(sym, *args)
        @program << sym
        @program.concat args
      end
    end
  end
end
