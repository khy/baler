# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{baler}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kevin Hyland"]
  s.date = %q{2010-04-03}
  s.description = %q{Parser adapter for Ruby objects}
  s.email = %q{khy@me.com}
  s.extra_rdoc_files = ["CHANGELOG", "LICENSE", "README.rdoc", "lib/baler.rb", "lib/baler/base.rb", "lib/baler/configuration.rb", "lib/baler/error.rb", "lib/baler/parser.rb", "lib/baler/parser/adapter.rb", "lib/baler/parser/adapter/base.rb", "lib/baler/parser/adapter/base/collection.rb", "lib/baler/parser/adapter/base/document.rb", "lib/baler/parser/adapter/base/element.rb", "lib/baler/parser/adapter/hpricot.rb", "lib/baler/parser/adapter/hpricot/collection.rb", "lib/baler/parser/adapter/hpricot/document.rb", "lib/baler/parser/adapter/hpricot/element.rb", "lib/baler/parser/collection.rb", "lib/baler/parser/document.rb", "lib/baler/parser/document/collection.rb", "lib/baler/parser/element.rb", "lib/baler/parser/spec/asset/alternate.html", "lib/baler/parser/spec/asset/blog.html", "lib/baler/parser/spec/collection_spec.rb", "lib/baler/parser/spec/document_collection_spec.rb", "lib/baler/parser/spec/document_spec.rb", "lib/baler/parser/spec/element_spec.rb", "lib/baler/parser/spec/matcher/parser_matcher.rb", "lib/baler/parser/spec/parser_spec.rb", "lib/baler/parser/spec/spec_helper.rb", "lib/baler/parser/support.rb", "lib/baler/remote.rb", "lib/baler/remote/extraction.rb", "lib/baler/remote/gather_condition.rb", "lib/baler/remote/source.rb", "lib/baler/remote/source/builder.rb", "lib/baler/remote/url.rb", "lib/baler/remote/url/dynamic.rb", "lib/baler/remote/url/static.rb", "lib/baler/support.rb"]
  s.files = ["CHANGELOG", "LICENSE", "README.rdoc", "Rakefile", "lib/baler.rb", "lib/baler/base.rb", "lib/baler/configuration.rb", "lib/baler/error.rb", "lib/baler/parser.rb", "lib/baler/parser/adapter.rb", "lib/baler/parser/adapter/base.rb", "lib/baler/parser/adapter/base/collection.rb", "lib/baler/parser/adapter/base/document.rb", "lib/baler/parser/adapter/base/element.rb", "lib/baler/parser/adapter/hpricot.rb", "lib/baler/parser/adapter/hpricot/collection.rb", "lib/baler/parser/adapter/hpricot/document.rb", "lib/baler/parser/adapter/hpricot/element.rb", "lib/baler/parser/collection.rb", "lib/baler/parser/document.rb", "lib/baler/parser/document/collection.rb", "lib/baler/parser/element.rb", "lib/baler/parser/spec/asset/alternate.html", "lib/baler/parser/spec/asset/blog.html", "lib/baler/parser/spec/collection_spec.rb", "lib/baler/parser/spec/document_collection_spec.rb", "lib/baler/parser/spec/document_spec.rb", "lib/baler/parser/spec/element_spec.rb", "lib/baler/parser/spec/matcher/parser_matcher.rb", "lib/baler/parser/spec/parser_spec.rb", "lib/baler/parser/spec/spec_helper.rb", "lib/baler/parser/support.rb", "lib/baler/remote.rb", "lib/baler/remote/extraction.rb", "lib/baler/remote/gather_condition.rb", "lib/baler/remote/source.rb", "lib/baler/remote/source/builder.rb", "lib/baler/remote/url.rb", "lib/baler/remote/url/dynamic.rb", "lib/baler/remote/url/static.rb", "lib/baler/support.rb", "spec/active_record_spec.rb", "spec/advanced_block_spec.rb", "spec/api_spec.rb", "spec/assets/orm/active_record/config/environment.rb", "spec/assets/orm/active_record/db/migrate/001_create_games.rb", "spec/assets/orm/active_record/db/migrate/002_add_records.rb", "spec/assets/orm/active_record/db/test.db", "spec/assets/parser/alternate.html", "spec/assets/parser/game.html", "spec/basic_spec.rb", "spec/block_url_spec.rb", "spec/build_spec.rb", "spec/conditional_spec.rb", "spec/context_spec.rb", "spec/multiple_source_spec.rb", "spec/spec_helper.rb", "spec/standard_block_spec.rb", "spec/url_mapping_spec.rb", "Manifest", "baler.gemspec"]
  s.homepage = %q{http://github.com/khy/recon}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Baler", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{baler}
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{A framework that helps package raw data into neat Ruby objects}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 1.3.0"])
    else
      s.add_dependency(%q<rspec>, [">= 1.3.0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.3.0"])
  end
end
