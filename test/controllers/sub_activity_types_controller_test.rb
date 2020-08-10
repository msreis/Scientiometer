require 'test_helper'

class SubActivityTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sub_activity_type = sub_activity_types(:one)
  end

  test "should get index" do
    get sub_activity_types_url, as: :json
    assert_response :success
  end

  test "should create sub_activity_type" do
    assert_difference('SubActivityType.count') do
      post sub_activity_types_url, params: { sub_activity_type: { activity_type_id: @sub_activity_type.activity_type_id, name: @sub_activity_type.name } }, as: :json
    end

    assert_response 201
  end

  test "should show sub_activity_type" do
    get sub_activity_type_url(@sub_activity_type), as: :json
    assert_response :success
  end

  test "should update sub_activity_type" do
    patch sub_activity_type_url(@sub_activity_type), params: { sub_activity_type: { activity_type_id: @sub_activity_type.activity_type_id, name: @sub_activity_type.name } }, as: :json
    assert_response 200
  end

  test "should destroy sub_activity_type" do
    assert_difference('SubActivityType.count', -1) do
      delete sub_activity_type_url(@sub_activity_type), as: :json
    end

    assert_response 204
  end
end
