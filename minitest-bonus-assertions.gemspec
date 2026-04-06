# -*- encoding: utf-8 -*-
# stub: minitest-bonus-assertions 3.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "minitest-bonus-assertions".freeze
  s.version = "3.1.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/halostatue/minitest-bonus-assertions/issues", "changelog_uri" => "https://github.com/halostatue/minitest-bonus-assertions/blob/main/CHANGELOG.md", "rubygems_mfa_required" => "true", "source_code_uri" => "https://github.com/halostatue/minitest-bonus-assertions" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Austin Ziegler".freeze]
  s.date = "2026-04-06"
  s.description = "Bonus assertions for Minitest, providing assertions I (used to) use frequently, supporting only Ruby 2.0 or better.  > I have not used these regularly for tests in about ten years. They're still > likely good, but I no longer consider them necessary.".freeze
  s.email = ["halostatue@gmail.com".freeze]
  s.extra_rdoc_files = ["CHANGELOG.md".freeze, "CODE_OF_CONDUCT.md".freeze, "CONTRIBUTING.md".freeze, "CONTRIBUTORS.md".freeze, "LICENCE.md".freeze, "Manifest.txt".freeze, "README.md".freeze, "SECURITY.md".freeze, "licences/dco.txt".freeze]
  s.files = ["CHANGELOG.md".freeze, "CODE_OF_CONDUCT.md".freeze, "CONTRIBUTING.md".freeze, "CONTRIBUTORS.md".freeze, "LICENCE.md".freeze, "Manifest.txt".freeze, "README.md".freeze, "Rakefile".freeze, "SECURITY.md".freeze, "lib/minitest-bonus-assertions.rb".freeze, "lib/minitest/assertion_tests.rb".freeze, "lib/minitest/bonus_assertions.rb".freeze, "lib/minitest/bonus_assertions/version.rb".freeze, "licences/dco.txt".freeze, "test/minitest_config.rb".freeze, "test/test_minitest-bonus-assertions.rb".freeze]
  s.homepage = "https://github.com/halostatue/minitest-bonus-assertions".freeze
  s.licenses = ["MIT".freeze]
  s.rdoc_options = ["--main".freeze, "README.md".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0".freeze)
  s.rubygems_version = "3.6.9".freeze
  s.summary = "Bonus assertions for Minitest, providing assertions I (used to) use frequently, supporting only Ruby 2.0 or better".freeze

  s.specification_version = 4

  s.add_development_dependency(%q<hoe>.freeze, ["~> 4.0".freeze])
  s.add_development_dependency(%q<hoe-halostatue>.freeze, ["~> 2.1".freeze, ">= 2.1.1".freeze])
  s.add_development_dependency(%q<minitest>.freeze, [">= 5.16".freeze, "< 7".freeze])
  s.add_development_dependency(%q<minitest-focus>.freeze, ["~> 1.1".freeze])
  s.add_development_dependency(%q<rake>.freeze, [">= 10.0".freeze, "< 14".freeze])
  s.add_development_dependency(%q<rdoc>.freeze, [">= 0.0".freeze, "< 7".freeze])
  s.add_development_dependency(%q<simplecov>.freeze, ["~> 0.22".freeze])
  s.add_development_dependency(%q<simplecov-lcov>.freeze, ["~> 0.8".freeze])
  s.add_development_dependency(%q<standard>.freeze, ["~> 1.0".freeze])
end
