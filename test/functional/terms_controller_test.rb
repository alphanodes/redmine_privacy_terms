# frozen_string_literal: true

require File.expand_path '../../test_helper', __FILE__

class TermsControllerTest < Redmine::ControllerTest
  fixtures :all

  def setup
    Setting.default_language = 'en'
    User.current = nil
  end

  def test_accept
    user = User.find 2

    assert user.save
    @request.session[:user_id] = user.id

    get :accept

    assert_response :found
  end

  def test_reject
    user = User.find 2

    assert user.save
    @request.session[:user_id] = user.id

    get :reject

    assert_response :found
  end

  def test_reset_should_require_admin
    user = User.find 2

    assert user.save
    @request.session[:user_id] = user.id

    get :reset

    assert_response :forbidden
  end
end
