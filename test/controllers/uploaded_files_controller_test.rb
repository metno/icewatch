require 'test_helper'

class UploadedFilesControllerTest < ActionController::TestCase
  setup do
    @uploaded_files = uploaded_files(:one)
  end

  test "should create uploaded_files" do
    login_user(:manager)
    assert_difference('UploadedFile.count') do
    post :create, params: { cruise_id: cruises(:cruise_0), uploaded_file: { file: fixture_file_upload('images/vegas.jpg', 'image/jpg') } }
    end

  end

end
