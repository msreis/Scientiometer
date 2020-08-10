require 'test_helper'

class CollaborationTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @collaboration_type = collaboration_types(:one)
  end

  test "should get index" do
    get collaboration_types_url, as: :json
    assert_response :success
  end

  test "should create collaboration_type" do
    assert_difference('CollaborationType.count') do
      post collaboration_types_url, params: { collaboration_type: { collaboration: @collaboration_type.collaboration } }, as: :json
    end

    assert_response 201
  end

  test "should show collaboration_type" do
    get collaboration_type_url(@collaboration_type), as: :json
    assert_response :success
  end

  test "should update collaboration_type" do
    patch collaboration_type_url(@collaboration_type), params: { collaboration_type: { collaboration: @collaboration_type.collaboration } }, as: :json
    assert_response 200
  end

  test "should destroy collaboration_type" do
    assert_difference('CollaborationType.count', -1) do
      delete collaboration_type_url(@collaboration_type), as: :json
    end

    assert_response 204
  end
end
