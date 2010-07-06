task :default => :spec

desc "Run the Pegarus specs (default)"
task :spec do
  sh "mspec -T -I#{File.expand_path('../', __FILE__)} spec"
end
