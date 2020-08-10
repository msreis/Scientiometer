require 'test_helper'

class ProductivityGrantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @productivity_grant = productivity_grants(:one)
  end

  test "should get index" do
    get productivity_grants_url, as: :json
    assert_response :success
  end

  test "should create productivity_grant" do
    assert_difference('ProductivityGrant.count') do
      post productivity_grants_url, params: { productivity_grant: { cnpq_level_id: @productivity_grant.cnpq_level_id, researcher_id: @productivity_grant.researcher_id, validity_end: @productivity_grant.validity_end, validity_start: @productivity_grant.validity_start } }, as: :json
    end

    assert_response 201
  end

  test "should show productivity_grant" do
    get productivity_grant_url(@productivity_grant), as: :json
    assert_response :success
  end

  test "should update productivity_grant" do
    patch productivity_grant_url(@productivity_grant), params: { productivity_grant: { cnpq_level_id: @productivity_grant.cnpq_level_id, researcher_id: @productivity_grant.researcher_id, validity_end: @productivity_grant.validity_end, validity_start: @productivity_grant.validity_start } }, as: :json
    assert_response 200
  end

  test "should destroy productivity_grant" do
    assert_difference('ProductivityGrant.count', -1) do
      delete productivity_grant_url(@productivity_grant), as: :json
    end

    assert_response 204
  end
end
