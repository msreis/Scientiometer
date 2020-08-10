require 'test_helper'

class ActivityTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @activity_type = activity_types(:one)
  end

  test "should get index" do
    get activity_types_url, as: :json
    assert_response :success
  end

  test "should create activity_type" do
    assert_difference('ActivityType.count') do
      post activity_types_url, params: { activity_type: { name: @activity_type.name } }, as: :json
    end

    assert_response 201
  end

  test "should show activity_type" do
    get activity_type_url(@activity_type), as: :json
    assert_response :success
  end

  test "should update activity_type" do
    patch activity_type_url(@activity_type), params: { activity_type: { name: @activity_type.name } }, as: :json
    assert_response 200
  end

  test "should destroy activity_type" do
    assert_difference('ActivityType.count', -1) do
      delete activity_type_url(@activity_type), as: :json
    end

    assert_response 204
  end
end
