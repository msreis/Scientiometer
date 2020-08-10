require 'test_helper'

class MultiuserActivitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @multiuser_activity = multiuser_activities(:one)
  end

  test "should get index" do
    get multiuser_activities_url, as: :json
    assert_response :success
  end

  test "should create multiuser_activity" do
    assert_difference('MultiuserActivity.count') do
      post multiuser_activities_url, params: { multiuser_activity: { activity_id: @multiuser_activity.activity_id, multiuser_id: @multiuser_activity.multiuser_id, year: @multiuser_activity.year } }, as: :json
    end

    assert_response 201
  end

  test "should show multiuser_activity" do
    get multiuser_activity_url(@multiuser_activity), as: :json
    assert_response :success
  end

  test "should update multiuser_activity" do
    patch multiuser_activity_url(@multiuser_activity), params: { multiuser_activity: { activity_id: @multiuser_activity.activity_id, multiuser_id: @multiuser_activity.multiuser_id, year: @multiuser_activity.year } }, as: :json
    assert_response 200
  end

  test "should destroy multiuser_activity" do
    assert_difference('MultiuserActivity.count', -1) do
      delete multiuser_activity_url(@multiuser_activity), as: :json
    end

    assert_response 204
  end
end
