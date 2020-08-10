require 'test_helper'

class GrantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @grant = grants(:one)
  end

  test "should get index" do
    get grants_url, as: :json
    assert_response :success
  end

  test "should create grant" do
    assert_difference('Grant.count') do
      post grants_url, params: { grant: { funding_agency_id: @grant.funding_agency_id, grant_participation_type_id: @grant.grant_participation_type_id, grant_project_type_id: @grant.grant_project_type_id, process_number: @grant.process_number, researcher_id: @grant.researcher_id, validity_end: @grant.validity_end, validity_start: @grant.validity_start, value_BRL: @grant.value_BRL, value_USD: @grant.value_USD } }, as: :json
    end

    assert_response 201
  end

  test "should show grant" do
    get grant_url(@grant), as: :json
    assert_response :success
  end

  test "should update grant" do
    patch grant_url(@grant), params: { grant: { funding_agency_id: @grant.funding_agency_id, grant_participation_type_id: @grant.grant_participation_type_id, grant_project_type_id: @grant.grant_project_type_id, process_number: @grant.process_number, researcher_id: @grant.researcher_id, validity_end: @grant.validity_end, validity_start: @grant.validity_start, value_BRL: @grant.value_BRL, value_USD: @grant.value_USD } }, as: :json
    assert_response 200
  end

  test "should destroy grant" do
    assert_difference('Grant.count', -1) do
      delete grant_url(@grant), as: :json
    end

    assert_response 204
  end
end
