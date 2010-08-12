task :default => :spec

BASE_DIR = File.expand_path('../', __FILE__)
RUBY = ENV["RUBY"] || "rbx"

def spec(r, m)
  ENV["PEGARUS_MACHINE"] = m
  sh("mspec -t #{r} -T -I#{BASE_DIR} spec") { |ok, res|  }
end

desc "Run the specs (default)"
task :spec do
  spec RUBY, "vm"
end

namespace :spec do
  desc "Run the Pegarus specs with Rubinius and VM"
  task "rbx:vm" do
    spec "rbx", "vm"
  end

  desc "Run the Pegarus specs with Rubinius and JIT"
  task "rbx:jit" do
    spec "rbx", "xjit"
  end

  desc "Run the specs with MRI"
  task :ruby do
    spec "ruby", "vm"
  end

  desc "Run the specs with all engines"
  task :all => ["rbx:jit", "rbx:vm", :ruby]
end
