require "test_helper"

class Api::V1::UserStatusesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_status = user_statuses(:john_doe)
  end

  test "should get show" do
    get api_v1_user_status_url(@user_status)
    assert_response :success
  end
end
