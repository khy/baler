require 'rake'
require 'spec/rake/spectask'

desc "Run all spec tests with RCov"
Spec::Rake::SpecTask.new('examples_with_rcov') do |t|
  t.spec_files = FileList['spec/**/*.rb']
  t.rcov = true
  t.rcov_dir = 'spec/coverage'
  t.rcov_opts = ['--exclude', 'spec']
end