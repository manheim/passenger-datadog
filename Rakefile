# frozen_string_literal: true
require 'rake'
require 'rspec/core'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

if RUBY_VERSION >= '2.0.0'
  require 'rubocop/rake_task'
  desc 'Run RuboCop'
  RuboCop::RakeTask.new(:rubocop) do |task|
    task.options = ['--display-cop-names']
  end

  task :default => [:spec, :rubocop]
else
  task :default => [:spec]
end
