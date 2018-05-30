require File.expand_path('../test_helper', __dir__)

class TermsControllerTest < Redmine::ControllerTest
  fixtures :projects,
           :users, :email_addresses, :user_preferences,
           :roles,
           :members,
           :member_roles

  def setup
    Setting.default_language = 'en'
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    User.current = nil
  end

  def test_accept
    user = User.find(2)
    assert user.save
    @request.session[:user_id] = user.id

    get :accept
    assert_response 302
  end

  def test_reject
    user = User.find(2)
    assert user.save
    @request.session[:user_id] = user.id

    get :reject
    assert_response 302
  end

  def test_reset_should_require_admin
    user = User.find(2)
    assert user.save
    @request.session[:user_id] = user.id

    get :reset
    assert_response 403
  end
end
