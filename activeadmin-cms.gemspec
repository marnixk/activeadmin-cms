# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'activeadmin-cms/version'

Gem::Specification.new do |gem|
  gem.name          = "activeadmin-cms"
  gem.version       = Cmsgem::VERSION
  gem.authors       = ["Marnix"]
  gem.email         = ["marnixkok+cmsgem@gmail.com"]
  gem.description   = %q{CMS module for ActiveAdmin}
  gem.summary       = %q{A standard CMS module for the ActiveAdmin module with pages, templates and a simple media database}
  gem.homepage      = "http://github.com/marnixk/activeadmin-cms"


  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'i18n'
  gem.add_dependency 'devise'
  gem.add_dependency 'activerecord'
  gem.add_dependency 'paperclip'
  gem.add_dependency 'activeadmin'
  gem.add_dependency 'tinymce-rails'
end
