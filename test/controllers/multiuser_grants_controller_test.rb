require 'test_helper'

class MultiuserGrantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @multiuser_grant = multiuser_grants(:one)
  end

  test "should get index" do
    get multiuser_grants_url, as: :json
    assert_response :success
  end

  test "should create multiuser_grant" do
    assert_difference('MultiuserGrant.count') do
      post multiuser_grants_url, params: { multiuser_grant: { grant_id: @multiuser_grant.grant_id, multiuser_id: @multiuser_grant.multiuser_id, year: @multiuser_grant.year } }, as: :json
    end

    assert_response 201
  end

  test "should show multiuser_grant" do
    get multiuser_grant_url(@multiuser_grant), as: :json
    assert_response :success
  end

  test "should update multiuser_grant" do
    patch multiuser_grant_url(@multiuser_grant), params: { multiuser_grant: { grant_id: @multiuser_grant.grant_id, multiuser_id: @multiuser_grant.multiuser_id, year: @multiuser_grant.year } }, as: :json
    assert_response 200
  end

  test "should destroy multiuser_grant" do
    assert_difference('MultiuserGrant.count', -1) do
      delete multiuser_grant_url(@multiuser_grant), as: :json
    end

    assert_response 204
  end
end
