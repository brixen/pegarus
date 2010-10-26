require 'pegarus/machine/instructions'
require 'pegarus/machine/generator'
require 'pegarus/machine/label'
require 'pegarus/machine/compiler'
require 'pegarus/machine/state'
require 'pegarus/machine/interpreter'

module Pegarus
  module Machine
    def self.new_executor(pattern, subject)
      Compiler.new.compile pattern
      pattern.match subject
    end
  end
end

Pegarus::Pattern.select_engine Pegarus::Machine
