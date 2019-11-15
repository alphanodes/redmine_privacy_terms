require File.expand_path('../../test_helper', __FILE__)

class I18nTest < ActiveSupport::TestCase
  include Redmine::I18n

  def setup
    User.current = nil
  end

  def teardown
    set_language_if_valid 'en'
  end

  def test_valid_languages
    assert valid_languages.is_a?(Array)
    assert valid_languages.first.is_a?(Symbol)
  end

  def test_locales_validness
    lang_files_count = Dir[Rails.root.join('plugins',
                                           'redmine_privacy_terms',
                                           'config',
                                           'locales',
                                           '*.yml')].size
    assert_equal lang_files_count, 2
    valid_languages.each do |lang|
      assert set_language_if_valid(lang)
    end
    # check if parse error exists
    ::I18n.locale = 'de'
    assert_equal 'Ergebnis', l(:field_privacy_terms_result)
    ::I18n.locale = 'en'
    assert_equal 'Result', l(:field_privacy_terms_result)

    set_language_if_valid('en')
  end
end
