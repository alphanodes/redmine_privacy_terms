# frozen_string_literal: true

require File.expand_path '../../test_helper', __FILE__

class TermsAgreementTest < Redmine::IntegrationTest
  include RedminePrivacyTerms::TestHelper

  fixtures :all

  TERMS_SETTINGS = { enable_terms: 1,
                     terms_page: 'CookBook_documentation',
                     terms_project_id: 1,
                     terms_reject_page: 'Another_page',
                     terms_reject_project_id: 1 }.freeze

  def setup
    Setting.default_language = 'en'
    RedminePrivacyTerms::TestCase.prepare
  end

  def test_user_without_agreement_is_redirected_to_terms
    with_plugin_settings 'redmine_privacy_terms', **TERMS_SETTINGS do
      log_user 'jsmith', 'jsmith'

      follow_redirect!

      assert_redirected_to RedminePrivacyTerms.terms_url(:en)
    end
  end

  # Redmine forces the 2FA setup before anything else and skips its own
  # check_twofa_activation filter on the setup pages. Without letting the terms
  # check pass there too, both redirects bounce off each other (#15721).
  def test_twofa_setup_is_reachable_while_agreement_is_open
    with_settings twofa: '2' do
      with_plugin_settings 'redmine_privacy_terms', **TERMS_SETTINGS do
        log_user 'jsmith', 'jsmith'

        follow_redirect!

        assert_redirected_to '/my/twofa/totp/activate/confirm'

        follow_redirect!

        assert_response :success
      end
    end
  end

  # The session flag is only set at login, so a 2FA requirement added to a
  # running session must not switch the terms check off.
  def test_terms_still_enforced_when_twofa_requirement_starts_after_login
    with_plugin_settings 'redmine_privacy_terms', **TERMS_SETTINGS do
      log_user 'jsmith', 'jsmith'

      with_settings twofa: '2' do
        get '/issues'

        assert_redirected_to RedminePrivacyTerms.terms_url(:en)
      end
    end
  end
end
