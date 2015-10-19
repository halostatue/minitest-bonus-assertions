# -*- ruby -*-

require 'rubygems'
require 'hoe'
require 'rake/clean'

Hoe.plugin :doofus
Hoe.plugin :gemspec2
Hoe.plugin :git
Hoe.plugin :minitest
Hoe.plugin :travis
Hoe.plugin :email unless ENV['CI'] or ENV['TRAVIS']

spec = Hoe.spec 'minitest-bonus-assertions' do
  developer('Austin Ziegler', 'halostatue@gmail.com')

  self.history_file = 'History.rdoc'
  self.readme_file = 'README.rdoc'
  self.extra_rdoc_files = FileList["*.rdoc"].to_a -
    %w(History.rdoc README.rdoc)

  license "MIT"

  self.need_tar = true
  self.require_ruby_version '>= 1.9.2'

  self.extra_dev_deps << ['hoe-doofus', '~> 1.0']
  self.extra_dev_deps << ['hoe-gemspec2', '~> 1.1']
  self.extra_dev_deps << ['hoe-git', '~> 1.5']
  self.extra_dev_deps << ['hoe-travis', '~> 1.2']
  self.extra_dev_deps << ['minitest', '~> 5.8']
  self.extra_dev_deps << ['minitest-around', '~> 0.3']
  self.extra_dev_deps << ['minitest-autotest', '~> 1.0']
  self.extra_dev_deps << ['minitest-bisect', '~> 1.2']
  self.extra_dev_deps << ['minitest-focus', '~> 1.1']
  self.extra_dev_deps << ['minitest-moar', '~> 0.0']
  self.extra_dev_deps << ['minitest-pretty_diff', '~> 0.1']
  self.extra_dev_deps << ['rake', '>= 10.0']
  self.extra_dev_deps << ['simplecov', '~> 0.7']
end

namespace :test do
  task :coverage do
    spec.test_prelude = [
      'require "simplecov"',
      'SimpleCov.start("test_frameworks") { command_name "Minitest" }',
      'gem "minitest"'
    ].join('; ')
    Rake::Task['test'].execute
  end
  CLOBBER << 'coverage'
end

# vim: syntax=ruby
