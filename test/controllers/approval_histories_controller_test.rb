require 'test_helper'

class ApprovalHistoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @approval_history = approval_histories(:one)
  end

  test "should get index" do
    get approval_histories_url, as: :json
    assert_response :success
  end

  test "should create approval_history" do
    assert_difference('ApprovalHistory.count') do
      post approval_histories_url, params: { approval_history: { account_id: @approval_history.account_id, approval_action_id: @approval_history.approval_action_id, comment: @approval_history.comment, submission_id: @approval_history.submission_id } }, as: :json
    end

    assert_response 201
  end

  test "should show approval_history" do
    get approval_history_url(@approval_history), as: :json
    assert_response :success
  end

  test "should update approval_history" do
    patch approval_history_url(@approval_history), params: { approval_history: { account_id: @approval_history.account_id, approval_action_id: @approval_history.approval_action_id, comment: @approval_history.comment, submission_id: @approval_history.submission_id } }, as: :json
    assert_response 200
  end

  test "should destroy approval_history" do
    assert_difference('ApprovalHistory.count', -1) do
      delete approval_history_url(@approval_history), as: :json
    end

    assert_response 204
  end
end
