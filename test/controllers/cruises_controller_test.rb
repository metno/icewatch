require 'test_helper'

class CruisesControllerTest < ActionController::TestCase
  setup do
    @cruise = cruises(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:cruises)
  end

  test 'should get new' do
    login_user(:admin)
    get :new
    assert_response :success
  end

  test 'should create cruise' do
    login_user(:admin)
    assert_difference('Cruise.count') do
      post :create, cruise: { approved: @cruise.approved, ends_at: @cruise.ends_at, objective: @cruise.objective, starts_at: @cruise.starts_at, ship: @cruise.ship }
    end

    assert_redirected_to cruise_path(assigns(:cruise))
  end

  test 'should show cruise' do
    login_user(:admin)
    get :show, id: @cruise
    assert_response :success
  end

  test 'should get edit' do
    login_user(:admin)
    get :edit, id: @cruise
    assert_response :success
  end

  test 'should update cruise' do
    login_user(:admin)
    patch :update, id: @cruise, cruise: { approved: @cruise.approved, ends_at: @cruise.ends_at, objective: @cruise.objective, starts_at: @cruise.starts_at, ship: @cruise.ship }
    assert_redirected_to cruise_path(assigns(:cruise))
  end

  test 'should destroy cruise' do
    login_user(:admin)
    assert_difference('Cruise.count', -1) do
      delete :destroy, id: @cruise
    end

    assert_redirected_to cruises_path
  end
end
