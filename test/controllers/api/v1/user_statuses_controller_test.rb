require "test_helper"

class Api::V1::UserStatusesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_status = user_statuses(:john_doe)
  end

  test "should show existing user_status without creating a new one" do
    assert_no_difference("UserStatus.count") do
      get api_v1_user_status_url(@user_status)
    end

    assert_response :ok
  end

  test "should create a user_status when a new id is requested" do
    user_status = UserStatus.find_by(id: 1)
    user_status.destroy if user_status

    assert_difference("UserStatus.count") do
      get api_v1_user_status_url(id: 1)
    end

    assert_response :ok
  end

  test "should respond 422 with an error message on validation error" do
    skip
  end
end
