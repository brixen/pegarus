module Pegarus
  module Machine
    class State
      attr_accessor :ip, :next_ip, :index
      attr_reader :subject, :size, :stack, :captures

      def initialize(subject)
        @subject  = subject
        @size     = subject.size
        @ip       = 0
        @next_ip  = 0
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
