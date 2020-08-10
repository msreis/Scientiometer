require 'test_helper'

class RoleFoundationLevelsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @role_foundation_level = role_foundation_levels(:one)
  end

  test "should get index" do
    get role_foundation_levels_url, as: :json
    assert_response :success
  end

  test "should create role_foundation_level" do
    assert_difference('RoleFoundationLevel.count') do
      post role_foundation_levels_url, params: { role_foundation_level: { description: @role_foundation_level.description } }, as: :json
    end

    assert_response 201
  end

  test "should show role_foundation_level" do
    get role_foundation_level_url(@role_foundation_level), as: :json
    assert_response :success
  end

  test "should update role_foundation_level" do
    patch role_foundation_level_url(@role_foundation_level), params: { role_foundation_level: { description: @role_foundation_level.description } }, as: :json
    assert_response 200
  end

  test "should destroy role_foundation_level" do
    assert_difference('RoleFoundationLevel.count', -1) do
      delete role_foundation_level_url(@role_foundation_level), as: :json
    end

    assert_response 204
  end
end
