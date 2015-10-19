Gem::Specification.new do |s|
  s.name = 'passenger_datadog'
  s.version = '0.1.0'
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 1.9.3'
  s.authors = ['Ryan Rosenblum']
  s.description = <<-EOF
    A tool for sending Passenger stats to Datadog.
  EOF

  s.email = 'passenger_datadog@manheim.com'
  s.files = %w(lib/passenger_datadog.rb bin/passenger-datadog)
  s.test_files = []
  s.executables = 'passenger-datadog'
  s.extra_rdoc_files = ['LICENSE', 'README.md']
  s.homepage = 'https://github.com/rrosenblum/passenger-datadog'
  s.licenses = ['MIT']
  s.require_paths = ['lib']
  s.rubygems_version = '1.8.23'
  s.summary = 'A tool for sending Passenger stats to Datadog'

  s.add_runtime_dependency('dogstatsd-ruby', '~> 1.5')
  s.add_runtime_dependency('nokogiri', '~> 1.6', '>= 1.6.6.2')
  s.add_runtime_dependency('passenger', '5.0.20')
  s.add_development_dependency('bundler', '> 1.3')
  s.add_development_dependency('rake', '~> 10.1')
  s.add_development_dependency('rspec', '~> 3.3.0')
end
