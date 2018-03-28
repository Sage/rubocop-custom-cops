lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'rubocop-custom-cops'
  spec.version       = '0.0.1'
  spec.authors       = ['Sage One team']
  spec.email         = ['support@sageone.com']

  spec.summary       = 'Custom Cops for Rubocop'
  spec.description   = 'Collection of custom checks for Rubocop.'
  spec.homepage      = 'https://github.com/Sage'
  spec.license       = 'Apache 2.0'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ['lib']

  spec.add_dependency 'rubocop', '>= 0.54.0'

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-doc'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'simplecov'
end
