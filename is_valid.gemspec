# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name        = 'is_valid'
  s.version     = '0.2.0'
  s.summary     = 'Validation of a variable or a hash, based on pre-defined or own easy rules'
  s.description = 'Ruby Gem to make a validation of a variable or a hash, based on regular expressions
  or own pre-defined validation templates in an easy way. See full documentation on GitHub.'
  s.authors     = ['Sergei Illarionov (www.butteff.ru/en/)']
  s.email       = 'butteff.ru@gmail.com'
  s.files       = ['lib/is_valid.rb']
  s.homepage    = 'https://butteff.ru/en/'
  s.license     = 'MIT'
  s.post_install_message = 'You can find docs about is_valid gem on https://butteff.ru/en/extensions or on https://github.com/butteff/is_valid_ruby_gem'
  s.metadata = { 'source_code_uri' => 'https://github.com/butteff/is_valid_ruby_gem',
                 'rubygems_mfa_required' => 'true' }
  s.required_ruby_version = '>= 2.7.0'
  s.add_development_dependency 'rspec', '~> 3.13'
  s.add_development_dependency 'rubocop', '~> 1.69'
end
