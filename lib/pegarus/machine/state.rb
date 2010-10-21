module Pegarus
  module Machine
    class State
      attr_accessor :ip, :index
      attr_reader :subject, :stack

      def initialize(subject)
        @subject  = subject
        @ip       = 0
        @index    = 0
        @stack    = []
        @fail     = false
      end

      def fail?
        @fail
      end

      def fail
        @fail = true
      end

      def continue
        @fail = false
      end
    end
  end
end
