$: << File.expand_path('../../lib', __FILE__)

require 'pegarus'

case ENV["PEGARUS_MACHINE"]
when "ruby"
  require 'pegarus/parsing_machine'
  Pegarus::Pattern.machine Pegarus::ParsingMachine
when "rbx"
  require 'pegarus/rubinius_jit'
  Pegarus::Pattern.machine Pegarus::RubiniusJIT
end
