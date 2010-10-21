require 'pegarus/machine/compiler'
require 'pegarus/machine/vm'

module Pegarus
  module ParsingMachine
    attr_reader :vm

    def match(subject)
      @vm = VM.new self

      class << self
        def match(subject)
          @vm.execute subject
        end
      end

      match subject
    end

  end
end
