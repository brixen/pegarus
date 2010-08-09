$: << File.expand_path('../../lib', __FILE__)

require 'pegarus'

case ENV["PEGARUS_MACHINE"]
when "ruby"
when "rbx"
  module Pegarus
    class Pattern
      include Instructions
    end
  end
end
