task :default => :spec

BASE_DIR = File.expand_path('../', __FILE__)
RUBY = ENV["RUBY"] || "rbx"

def spec(r)
  ENV["PEGARUS_MACHINE"] = r
  sh "mspec -t #{r} -T -I#{BASE_DIR} spec"
end

desc "Run the specs (default)"
task :spec do
  spec RUBY
end

namespace :spec do
  desc "Run the Pegarus specs with Rubinius"
  task :rbx do
    spec 'rbx'
  end

  desc "Run the specs with MRI"
  task :ruby do
    spec 'ruby'
  end
end
