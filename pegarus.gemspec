# coding: utf-8
require './lib/pegarus/version'

Gem::Specification.new do |spec|
  spec.name                      = "pegarus"
  spec.version                   = Pegarus::VERSION
  spec.authors                   = ["Brian Ford"]
  spec.email                     = ["brixen@gmail.com"]
  spec.summary                   = "Pegarus is an implementation of LPEG in Ruby."
  spec.description               = <<EOS
Pegarus is, broadly, an implementation of LPEG on Rubinius. LPEG implements a
Parsing Expression Grammar using a parsing machine rather than the Packrat
algorithm. (See "A Text Pattern-Matching Tool based on Parsing Expression
Grammars" by Roberto Ierusalimschy.)

Pegarus actually implements an abstract syntax tree (AST) for the PEG. There
are various options to execute the AST against a subject string. One option is
a simple AST-walking evaluator. A second option is an implementation of the
LPEG parsing machine. A third option is a compiler that targets Rubinius
bytecode.
EOS
  spec.homepage      = "https://github.com/brixen/pegarus"
  spec.license       = "BSD"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "mspec", "~> 1.5"
end
