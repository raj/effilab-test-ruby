# -*- encoding: utf-8 -*-
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.authors = ["raj"]
  gem.email = ["raj.deenoo@gmail.com"]
  gem.description = %q{Effilab test technique}
  gem.summary = %q{retrieve campaign data from adwords api and display to console}

  gem.files = `git ls-files`.split($\)
  gem.executables = ["ad_reporter"]
  gem.test_files = gem.files.grep(%r{^(test|spec|features)/})
  gem.name = "ad_reporter"
  gem.require_paths = ["lib"]
  gem.version = "0.0.1"

  gem.add_dependency "bundler", "~> 1.16"
  gem.add_dependency "parallel", "~>1.12"
  gem.add_dependency "google-adwords-api", "1.3.0"

  gem.add_development_dependency "rspec", "~>3.8"
  gem.add_development_dependency "webmock", "~>3.4"
  gem.add_development_dependency "simplecov", "~>0.16"
  gem.add_development_dependency "simplecov-console", "~>0.4.2"
end
