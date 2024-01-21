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
    lang_files_count = Dir[Rails.root.join('plugins/redmine_privacy_terms/config/locales/*.yml')].size

    assert_equal 2, lang_files_count

    valid_languages.each do |lang|
      assert set_language_if_valid(lang)
      case lang.to_s
      when 'en'

        assert_equal 'Result', l(:field_privacy_terms_result)
      when 'de'

        assert_not l(:field_privacy_terms_result) == 'Result', lang
      end
    end

    set_language_if_valid 'en'
  end
end
