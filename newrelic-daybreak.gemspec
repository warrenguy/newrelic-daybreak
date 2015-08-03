require_relative './lib/newrelic-daybreak/version'

Gem::Specification.new do |s|
  s.name        = 'newrelic-daybreak'
  s.version     = NewRelicDaybreak::VERSION
  s.licenses    = ['MIT']
  s.summary     = 'A simple redis backed cache for Sinatra'
  s.description = 'A simple redis backed cache for Sinatra'
  s.authors     = ['Warren Guy']
  s.email       = 'warren@guy.net.au'
  s.homepage    = 'https://github.com/warrenguy/newrelic-daybreak'

  s.files       = Dir['README.md', 'LICENSE', 'lib/**/*']

  s.add_dependency('daybreak', '~> 0.3')
  s.add_dependency('newrelic_rpm', '~> 3.11')
end
