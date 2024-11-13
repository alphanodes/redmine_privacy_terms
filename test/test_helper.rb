# frozen_string_literal: true

if ENV['COVERAGE']
  require 'simplecov'
  require 'simplecov-rcov'

  SimpleCov.formatters = SimpleCov::Formatter::MultiFormatter[SimpleCov::Formatter::HTMLFormatter,
                                                              SimpleCov::Formatter::RcovFormatter]

  SimpleCov.start :rails do
    add_filter 'init.rb'
    root File.expand_path "#{File.dirname __FILE__}/.."
  end
end

require File.expand_path "#{File.dirname __FILE__}/../../../test/test_helper"
require File.expand_path "#{File.dirname __FILE__}/../../additionals/test/global_test_helper"

module RedminePrivacyTerms
  class TestCase
    include ActionDispatch::TestProcess

    def self.prepare
      Role.where(id: [1, 2]).find_each do |r|
        r.permissions << :view_wiki_pages
        r.save
      end

      Project.where(id: [1, 2]).find_each do |project|
        EnabledModule.create project: project, name: 'wiki'
      end
    end
  end
end
