# frozen_string_literal: true

require File.expand_path '../../test_helper', __FILE__

class WelcomeControllerTest < RedminePrivacyTerms::ControllerTest
  # additionals renders a dashboard on the welcome page before the terms check
  # runs, so the request needs a system default dashboard to get that far.
  fixtures :dashboards, :dashboard_roles

  def setup
    prepare_tests
    Setting.default_language = 'en'
    User.current = nil
  end

  def test_user_without_agreement_is_redirected_to_terms
    @request.session[:user_id] = users(:users_002).id

    with_plugin_settings 'redmine_privacy_terms', **terms_settings do
      get :index

      assert_redirected_to RedminePrivacyTerms.terms_url(:en)
    end
  end

  # Redmine only sets the session flag at login, so a 2FA requirement that starts
  # during a running session must not switch the terms check off.
  def test_terms_enforced_when_twofa_requirement_starts_after_login
    @request.session[:user_id] = users(:users_002).id

    with_settings twofa: '2' do
      with_plugin_settings 'redmine_privacy_terms', **terms_settings do
        get :index

        assert_redirected_to RedminePrivacyTerms.terms_url(:en)
      end
    end
  end
end
