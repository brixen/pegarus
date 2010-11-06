module Pegarus
  module Machine
    class Generator
      attr_reader :program, :rules, :end_label

      def initialize
        @program   = []
        @rules     = []
        @labels    = {}
        @end_label = new_label
      end

      def new_label
        Label.new self
      end

      def label_for(variable)
        unless label = @labels[variable.name]
          label = new_label
          @labels[variable.name] = label
          @rules << variable
        end

        label
      end

      def ip
        @program.size
      end

      def call(label)
        add_with_label :call, label
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

      def jump(label)
        add_with_label :jump, label
      end

      def partial_commit(label)
        add_with_label :partial_commit, label
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
