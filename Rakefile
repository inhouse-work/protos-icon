# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task default: :spec

task :download_heroicons do
  system "git clone https://github.com/tailwindlabs/heroicons.git"
  system "cp -r heroicons/optimized/* assets/heroicons"
  system "rm -rf heroicons/"
end
