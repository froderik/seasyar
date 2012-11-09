# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "seasyar"
  gem.homepage = "http://github.com/froderik/seasyar"
  gem.license = "MIT"
  gem.summary = %Q{active record integration for seasy}
  gem.description = %Q{Seasy integration. Active record storage for seasy and save hooks in models.}
  gem.email = "fredrik@eldfluga.se"
  gem.authors = ["Fredrik Rubensson"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "seasyar #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new do |t|
  t.warning = true
  t.rcov = true
end

begin
  require 'tasks/standalone_migrations'
rescue LoadError => e
  puts "gem install standalone_migrations to get db:migrate:* tasks! (Error: #{e})"
end