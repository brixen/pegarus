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
        add_with_label :choice, label
      end

      def commit(label)
        add_with_label :commit, label
      end

      def back_commit(label)
        add_with_label :back_commit, label
      end

      def add_with_label(name, label)
        add name, label
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
