require 'rake/gempackagetask'

task :default => :spec

BASE_DIR = File.expand_path('../', __FILE__)
RUBY = ENV["RUBY"] || "rbx"

def spec(target)
  sh("mspec ci -t #{target} -T -I#{BASE_DIR} spec") { |ok, res|  }
end

desc "Run the specs with $RUBY or 'rbx' (default)"
task :spec do
  spec RUBY
end

namespace :spec do
  desc "Run the specs with Rubinius"
  task :rbx do
    spec "rbx"
  end

  desc "Run the specs with the 'ruby' on $PATH"
  task :ruby do
    spec "ruby"
  end

  desc "Run the specs with all engines"
  task :all => [:rbx, :ruby]
end

spec = Gem::Specification.new do |s|
  require File.expand_path('../lib/pegarus/version', __FILE__)

  s.name                      = "pegarus"
  s.version                   = Pegarus::VERSION.to_s

  s.specification_version     = 2 if s.respond_to? :specification_version=

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors                   = ["Brian Ford"]
  s.date                      = %q{2010-10-24}
  s.email                     = %q{brixen@gmail.com}
  s.has_rdoc                  = true
  s.extra_rdoc_files          = %w[ README LICENSE ]
  s.executables               = []
  s.files                     = FileList[ '{bin,lib,spec}/**/*.{yaml,txt,rb}', 'Rakefile', *s.extra_rdoc_files ]
  s.homepage                  = %q{http://github.com/brixen/pegarus}
  s.require_paths             = ["lib"]
  s.rubygems_version          = %q{1.3.5}
  s.summary                   = "Pegarus is an implementation of LPEG in Ruby."
  s.description               = <<EOS
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

  s.rdoc_options << '--title' << 'Pegarus Gem' <<
                   '--main' << 'README' <<
                   '--line-numbers'
end

Rake::GemPackageTask.new(spec){ |pkg| pkg.gem_spec = spec }
