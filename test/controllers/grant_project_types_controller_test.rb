require 'test_helper'

class GrantProjectTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @grant_project_type = grant_project_types(:one)
  end

  test "should get index" do
    get grant_project_types_url, as: :json
    assert_response :success
  end

  test "should create grant_project_type" do
    assert_difference('GrantProjectType.count') do
      post grant_project_types_url, params: { grant_project_type: { name: @grant_project_type.name } }, as: :json
    end

    assert_response 201
  end

  test "should show grant_project_type" do
    get grant_project_type_url(@grant_project_type), as: :json
    assert_response :success
  end

  test "should update grant_project_type" do
    patch grant_project_type_url(@grant_project_type), params: { grant_project_type: { name: @grant_project_type.name } }, as: :json
    assert_response 200
  end

  test "should destroy grant_project_type" do
    assert_difference('GrantProjectType.count', -1) do
      delete grant_project_type_url(@grant_project_type), as: :json
    end

    assert_response 204
  end
end
