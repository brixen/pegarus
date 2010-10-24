module Pegarus
  module Machine
    class State
      attr_accessor :ip, :index
      attr_reader :subject, :stack, :captures

      def initialize(subject)
        @subject  = subject
        @ip       = 0
        @index    = 0
        @stack    = []
        @captures = []
        @failure  = false
      end

      def failure?
        @failure
      end

      def failure
        @failure = true
      end

      def continue
        @failure = false
      end
    end
  end
end
