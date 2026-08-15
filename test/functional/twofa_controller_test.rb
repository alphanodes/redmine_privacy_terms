# frozen_string_literal: true

require File.expand_path '../../test_helper', __FILE__

class TwofaControllerTest < RedminePrivacyTerms::ControllerTest
  def setup
    prepare_tests
    Setting.default_language = 'en'
    User.current = nil
  end

  # Redmine sends users with a pending 2FA setup to the activation pages and skips
  # its own check_twofa_activation filter there. Without letting the terms check
  # pass as well, both redirects bounce off each other until the browser gives up.
  def test_select_scheme_is_reachable_while_agreement_is_open
    user = users :users_002

    assert_nil user.accept_terms_at

    @request.session[:user_id] = user.id
    @request.session[:must_activate_twofa] = '1'

    with_settings twofa: '2' do
      with_plugin_settings 'redmine_privacy_terms', **terms_settings do
        get :select_scheme

        assert_response :success
      end
    end
  end
end
