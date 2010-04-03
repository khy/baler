require 'rubygems'
require 'rake'
require 'echoe'
require 'spec/rake/spectask'

Echoe.new('baler', '0.1.0') do |p|
  p.description               = 'Parser adapter for Ruby objects'
  p.summary                   = 'A framework that helps package raw data into neat Ruby objects'
  p.url                       = 'http://github.com/khy/recon'
  p.author                    = 'Kevin Hyland'
  p.email                     = 'khy@me.com'
  p.development_dependencies  = ['rspec >=1.3.0']
end


desc "Run all spec tests with RCov"
Spec::Rake::SpecTask.new('examples_with_rcov') do |t|
  t.spec_files = FileList['spec/**/*.rb']
  t.rcov = true
  t.rcov_dir = 'spec/coverage'
  t.rcov_opts = ['--exclude', 'spec']
end