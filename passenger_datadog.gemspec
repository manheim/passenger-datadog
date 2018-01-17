# frozen_string_literal: true
Gem::Specification.new do |s|
  s.name = 'passenger_datadog'
  s.version = '0.2.1'
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.2.0'
  s.authors = ['Ryan Rosenblum']
  s.description = <<-EOF
    A tool for sending Passenger stats to Datadog.
  EOF

  s.email = 'passenger_datadog@manheim.com'
  s.files = %w(lib/passenger_datadog.rb bin/passenger-datadog bin/passenger-datadog)
  s.test_files = []
  s.executables = %w(passenger-datadog)
  s.extra_rdoc_files = ['LICENSE', 'README.md']
  s.homepage = 'https://github.com/manheim/passenger-datadog'
  s.licenses = ['MIT']
  s.require_paths = ['lib']
  s.rubygems_version = '1.8.23'
  s.summary = 'A tool for sending Passenger stats to Datadog'

  s.add_runtime_dependency('daemons', '~> 1.0')
  s.add_runtime_dependency('dogstatsd-ruby', '>= 2.0.0', '< 4.0.0')
  s.add_runtime_dependency('nokogiri', '~> 1.0')
  s.add_runtime_dependency('passenger', '>= 4.0.0', '<= 6.0.0')

  s.add_development_dependency('rake', '~> 10.1')
  s.add_development_dependency('rubocop', '~> 0.44.0')
  s.add_development_dependency('rspec', '~> 3.3')
end
