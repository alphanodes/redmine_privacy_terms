# frozen_string_literal: true

require File.expand_path '../../test_helper', __FILE__

class I18nTest < RedminePrivacyTerms::TestCase
  Additionals.define_i18n_tests self,
                                plugin: 'redmine_privacy_terms',
                                control_string: :field_privacy_terms_result,
                                control_english: 'Result'
end
