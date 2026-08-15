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
  module TestHelper
    include Additionals::GlobalTestHelper

    def prepare_tests
      Role.where(id: [1, 2]).find_each do |r|
        r.permissions << :view_wiki_pages
        r.save
      end

      Project.where(id: [1, 2]).find_each do |project|
        EnabledModule.create project: project, name: 'wiki'
      end
    end

    # Wiki pages the terms settings point at in tests. Both pages come from the
    # Redmine core fixtures, so no extra setup is needed.
    def terms_settings
      { enable_terms: 1,
        terms_page: 'CookBook_documentation',
        terms_project_id: 1,
        terms_reject_page: 'Another_page',
        terms_reject_project_id: 1 }
    end
  end

  class ControllerTest < Redmine::ControllerTest
    include RedminePrivacyTerms::TestHelper

    fixtures :all
  end

  class TestCase < ActiveSupport::TestCase
    include ActionDispatch::TestProcess
    include RedminePrivacyTerms::TestHelper

    fixtures :all
  end
end
