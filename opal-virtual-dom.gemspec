Gem::Specification.new do |s|
  s.name        = 'opal-virtual-dom'
  s.version     = '0.4.4'
  s.authors     = ['Michał Kalbarczyk']
  s.email       = 'fazibear@gmail.com'
  s.homepage    = 'http://github.com/fazibear/opal-virtual-dom'
  s.summary     = 'virtual-dom wrapper for opal'
  s.description = 'virtual-dom wrapper for opal'
  s.license     = 'MIT'

  s.files         = `git ls-files`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ['lib']

  s.add_dependency 'opal'
  s.add_development_dependency 'rake'
end
