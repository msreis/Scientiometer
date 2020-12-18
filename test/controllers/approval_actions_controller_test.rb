require 'test_helper'

class ApprovalActionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @approval_action = approval_actions(:one)
  end

  test "should get index" do
    get approval_actions_url, as: :json
    assert_response :success
  end

  test "should create approval_action" do
    assert_difference('ApprovalAction.count') do
      post approval_actions_url, params: { approval_action: { name: @approval_action.name } }, as: :json
    end

    assert_response 201
  end

  test "should show approval_action" do
    get approval_action_url(@approval_action), as: :json
    assert_response :success
  end

  test "should update approval_action" do
    patch approval_action_url(@approval_action), params: { approval_action: { name: @approval_action.name } }, as: :json
    assert_response 200
  end

  test "should destroy approval_action" do
    assert_difference('ApprovalAction.count', -1) do
      delete approval_action_url(@approval_action), as: :json
    end

    assert_response 204
  end
end
