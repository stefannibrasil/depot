require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should prompt for login" do
    get login_path
    assert_response :success
  end

  test "should login" do
    steff = users(:one)
    post login_path, params: { username: steff.username, password: 'secret' }
    assert_redirected_to admin_url
    assert_equal steff.id, session[:user_id]
  end

  test "should fail login" do
    steff = users(:one)
    post login_path, params: { username: steff.username, password: 'wrong' }
    assert_redirected_to login_url
  end

  test "should logout" do
    delete logout_url
    assert_redirected_to store_index_url
  end
end
