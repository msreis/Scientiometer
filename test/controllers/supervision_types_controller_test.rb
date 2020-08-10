require 'test_helper'

class SupervisionTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @supervision_type = supervision_types(:one)
  end

  test "should get index" do
    get supervision_types_url, as: :json
    assert_response :success
  end

  test "should create supervision_type" do
    assert_difference('SupervisionType.count') do
      post supervision_types_url, params: { supervision_type: { type: @supervision_type.type } }, as: :json
    end

    assert_response 201
  end

  test "should show supervision_type" do
    get supervision_type_url(@supervision_type), as: :json
    assert_response :success
  end

  test "should update supervision_type" do
    patch supervision_type_url(@supervision_type), params: { supervision_type: { type: @supervision_type.type } }, as: :json
    assert_response 200
  end

  test "should destroy supervision_type" do
    assert_difference('SupervisionType.count', -1) do
      delete supervision_type_url(@supervision_type), as: :json
    end

    assert_response 204
  end
end
