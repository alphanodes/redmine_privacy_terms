# frozen_string_literal: true

require File.expand_path '../../test_helper', __FILE__

class I18nTest < ActiveSupport::TestCase
  include Redmine::I18n

  def setup
    User.current = nil
  end

  def teardown
    set_language_if_valid 'en'
  end

  def test_valid_languages
    assert_kind_of Array, valid_languages
    assert_kind_of Symbol, valid_languages.first
  end

  def test_locales_validness
    assert_locales_validness plugin: 'redmine_privacy_terms',
                             file_cnt: 2,
                             locales: %w[de],
                             control_string: :field_privacy_terms_result,
                             control_english: 'Result'
  end
end
