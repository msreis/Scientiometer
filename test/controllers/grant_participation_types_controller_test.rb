require 'test_helper'

class GrantParticipationTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @grant_participation_type = grant_participation_types(:one)
  end

  test "should get index" do
    get grant_participation_types_url, as: :json
    assert_response :success
  end

  test "should create grant_participation_type" do
    assert_difference('GrantParticipationType.count') do
      post grant_participation_types_url, params: { grant_participation_type: { name: @grant_participation_type.name } }, as: :json
    end

    assert_response 201
  end

  test "should show grant_participation_type" do
    get grant_participation_type_url(@grant_participation_type), as: :json
    assert_response :success
  end

  test "should update grant_participation_type" do
    patch grant_participation_type_url(@grant_participation_type), params: { grant_participation_type: { name: @grant_participation_type.name } }, as: :json
    assert_response 200
  end

  test "should destroy grant_participation_type" do
    assert_difference('GrantParticipationType.count', -1) do
      delete grant_participation_type_url(@grant_participation_type), as: :json
    end

    assert_response 204
  end
end
