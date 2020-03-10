require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def test_destroy_users 
    login_user(:admin)

    assert_difference('User.count', -1) do
      #users(:manager).destroy
      delete :destroy, params: { id: users(:manager).id }
    end

    assert_no_difference('User.count') do
      #users(:admin).destroy
      delete :destroy, params: { id: users(:admin).id }
    end

    assert_redirected_to users_path
  end
end
