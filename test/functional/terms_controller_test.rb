# frozen_string_literal: true

require File.expand_path '../../test_helper', __FILE__

class TermsControllerTest < RedminePrivacyTerms::ControllerTest
  def setup
    Setting.default_language = 'en'
    User.current = nil
  end

  def test_accept
    @request.session[:user_id] = users(:users_002).id

    get :accept

    assert_response :found
  end

  def test_reject
    @request.session[:user_id] = users(:users_002).id

    get :reject

    assert_response :found
  end

  def test_reset_should_require_admin
    @request.session[:user_id] = users(:users_002).id

    get :reset

    assert_response :forbidden
  end
end
