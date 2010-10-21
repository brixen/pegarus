$: << File.expand_path('../../lib', __FILE__)

require 'pegarus'

case ENV["PEGARUS_MACHINE"]
when "vm"
  require 'pegarus/machine'
  Pegarus::Pattern.machine Pegarus::ParsingMachine
when "xjit"
  require 'pegarus/rubinius'
  Pegarus::Pattern.machine Pegarus::RubiniusJIT
end
