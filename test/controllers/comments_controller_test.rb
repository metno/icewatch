require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  setup do
    @comment = comments(:one)
  end

  test 'should create comment' do
    assert_difference('Comment.count') do
      post :create, xhr: true, format: :js, params: { observation_id: @comment.observation.id, comment: {
        person_id_or_name: @comment.person_id,
        text: @comment.text
      } }
    end

    assert_response :success
  end

  test 'should get edit' do
    post :edit, xhr: true, format: :js, params: { id: @comment }
    assert_response :success
  end

  test 'should update comment' do
    patch :update, format: :js, params: { id: @comment, observation_id: @comment.observation.id, comment: {
      person_id_or_name: @comment.person_id,
      text: @comment.text
    } }

    assert_response :success
  end

  test 'should destroy comment' do
    assert_difference('Comment.count', -1) do
      delete :destroy, params: { id: @comment }
    end

    assert_redirected_to observation_path(@comment.observation)
  end
end
