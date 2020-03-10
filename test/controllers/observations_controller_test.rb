require 'test_helper'

class ObservationsControllerTest < ActionController::TestCase
  setup do
    @observation = observations(:base)
    @cruise = @observation.cruise
  end

  test 'should create observation' do
	  login_user(:admin)

    assert_difference('Observation.count') do
      post :create, params: { cruise_id: @cruise.id }
    end

    assert_redirected_to edit_observation_path(assigns(:observation))
  end

  test 'should show observation' do
    get :show, params: { id: @observation }
    assert_response :success
  end

  test 'should get edit' do
	  login_user(:admin)

    get :edit, params: { id: @observation }
    assert_response :success
  end

  test 'should update observation' do
    login_user(:admin)

    patch :update, params: { id: @observation, observation: { cruise_id: @observation.cruise_id, latitude: @observation.latitude, longitude: @observation.longitude, observed_at: @observation.observed_at, uuid: @observation.uuid } }
    assert_redirected_to edit_observation_path(assigns(:observation))
  end

  test 'should destroy observation' do
    login_user(:admin)

    assert_difference('Observation.count', -1) do
      delete :destroy, params: { id: @observation }
    end

    assert_redirected_to root_url
  end

  test 'should destroy all observations' do
    login_user(:admin)
    cruise = cruises(:cruise_0)

    assert_difference("Cruise.find(#{cruise.id}).observations.count", -30) do
      delete :all, params: { cruise_id: cruise }
    end

    assert_redirected_to cruise_url(cruise)
  end

  test 'should destroy unapproved observations' do
    login_user(:admin)
    cruise = cruises(:cruise_0)

    assert_difference("Cruise.find(#{cruise.id}).observations.count", -20) do
      delete :unapproved, params: { cruise_id: cruise }
    end

    assert_redirected_to cruise_url(cruise)
  end

  test 'should destroy invalid observations' do
    login_user(:admin)
    cruise = cruises(:cruise_0)

    assert_difference("Cruise.find(#{cruise.id}).observations.count", -10) do
      delete :invalid, params: { cruise_id: cruise }
    end

    assert_redirected_to cruise_url(cruise)
  end

  test 'should approve an observation' do
    login_user(:admin)
    observation = observations(:unapproved_observation_0)

    patch :approve, params: { id: observation }
    assert assigns(:observation).accepted?
    assert_redirected_to(cruise_path(observation.cruise))
  end

  test 'it shouldnt approve an invalid observation' do
    login_user(:admin)
    observation = observations(:invalid_observation_0)

    patch :approve, params: { id: observation }
    refute assigns(:observation).accepted?
    assert_redirected_to(cruise_path(observation.cruise))
    assert_equal 'Unable to approve an invalid observation', flash[:error]
  end


end

