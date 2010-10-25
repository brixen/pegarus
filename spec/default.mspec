# vim: filetype=ruby

require 'spec/custom/guards/engine'

class MSpecScript
  tags_dir = defined?(RUBY_ENGINE) ? RUBY_ENGINE : 'ruby'
  set :tags_patterns, [
                        [%r(spec/), "spec/#{tags_dir}/tags/"],
                        [/_spec.rb$/, '_tags.txt']
                      ]

  set :target, 'rbx'
end
