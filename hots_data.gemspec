require_relative 'lib/hots_data/version'

Gem::Specification.new do |spec|
  spec.name          = 'hots_data'
  spec.version       = HotsData::VERSION
  spec.authors       = ['Tobias Bühlmann']
  spec.email         = ['tobias+hotsdata@xn--bhlmann-n2a.de']

  spec.summary       = 'API Client for HotsData'
  spec.description   = ''
  spec.homepage      = 'https://github.com/tbuehlmann/hots_data'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'http'
end
