module Pegarus
  module Machine
    class Generator
      attr_reader :program

      def initialize
        @program = []
      end

      def new_label
        Label.new self
      end

      def ip
        @program.size
      end

      def choice(label)
        add :choice, label
        label.used_at ip - 1
      end

      def back_commit(label)
        add :back_commit, label
        label.used_at ip - 1
      end

      def add(name, *args)
        @program << name
        @program.concat args
      end

      def method_missing(sym, *args)
        add sym, *args
      end
    end
  end
end
