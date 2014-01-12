require "bundler/gem_tasks"

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
