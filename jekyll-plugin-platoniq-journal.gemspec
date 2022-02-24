# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "jekyll-plugin-platoniq-journal"
  spec.version       = "0.0.9"
  spec.authors       = ["Agustí B.R."]
  spec.email         = ["agusti@platoniq.net"]

  spec.summary       = "A collection of plugins for Jekyll."
  spec.homepage      = "https://github.com/Platoniq/jekyll-plugin-platoniq-journal"
  spec.license       = "AGPL-3.0"

  spec.files         = `git ls-files lib`.split("\n").concat(%w(LICENSE.txt README.md))

  spec.require_paths = ["lib"]
  spec.required_ruby_version = ">= 2.5"

  spec.add_dependency "jekyll", "~> 4.2"
  spec.add_dependency "kramdown", "~> 2.3"
  spec.add_development_dependency "bundler", "> 1.0", "< 3.0"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "rubocop-jekyll", "~> 0.12"
end
