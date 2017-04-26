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

  license 'MIT'

  require_ruby_version '>= 2.0'

  self.history_file = 'History.rdoc'
  self.readme_file = 'README.rdoc'
  self.extra_rdoc_files = FileList["*.rdoc"].to_a -
    %w(History.rdoc README.rdoc)

  extra_dev_deps << ['hoe-doofus', '~> 1.0']
  extra_dev_deps << ['hoe-gemspec2', '~> 1.1']
  extra_dev_deps << ['hoe-git', '~> 1.6']
  extra_dev_deps << ['hoe-travis', '~> 1.2']
  extra_dev_deps << ['minitest', '~> 5.8']
  extra_dev_deps << ['minitest-around', '~> 0.3']
  extra_dev_deps << ['minitest-autotest', '~> 1.0']
  extra_dev_deps << ['minitest-bisect', '~> 1.2']
  extra_dev_deps << ['minitest-bonus-assertions', '~> 2.0']
  extra_dev_deps << ['minitest-focus', '~> 1.1']
  extra_dev_deps << ['minitest-moar', '~> 0.0']
  extra_dev_deps << ['minitest-pretty_diff', '~> 0.1']
  extra_dev_deps << ['rake', '~> 10.0']
  extra_dev_deps << ['simplecov', '~> 0.7']
  extra_dev_deps << ['coveralls', '~> 0.7']
end

namespace :test do
  if ENV['CI'] or ENV['TRAVIS']
    desc "Submit test coverage to Coveralls"
    task :coveralls do
      spec.test_prelude = [
        'require "psych"',
        'require "simplecov"',
        'require "coveralls"',
        'SimpleCov.formatter = Coveralls::SimpleCov::Formatter',
        'SimpleCov.start("test_frameworks") { command_name "Minitest" }',
        'gem "minitest"'
      ].join('; ')
      Rake::Task['test'].execute
    end

      Rake::Task['travis'].prerequisites.replace(%w(test:coveralls))
  end

  desc "Runs test coverage. Only works Ruby 1.9+ and assumes 'simplecov' is installed."
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
