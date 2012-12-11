# -*- encoding: utf-8 -*-
require File.expand_path('../lib/atnd_create/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["ginkouno"]
  gem.email         = ["hoge@dummy.ne.jp"]
  gem.description   = %q{atnd_create}
  gem.summary       = %q{atnd_create}
  gem.homepage      = "https://github.com/ginkouno/atnd_create"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "atnd_crate"
  gem.require_paths = ["lib"]
  gem.version       = AtndCreate::VERSION
end
