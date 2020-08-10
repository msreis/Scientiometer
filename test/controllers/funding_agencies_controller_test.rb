require 'test_helper'

class FundingAgenciesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @funding_agency = funding_agencies(:one)
  end

  test "should get index" do
    get funding_agencies_url, as: :json
    assert_response :success
  end

  test "should create funding_agency" do
    assert_difference('FundingAgency.count') do
      post funding_agencies_url, params: { funding_agency: { name: @funding_agency.name } }, as: :json
    end

    assert_response 201
  end

  test "should show funding_agency" do
    get funding_agency_url(@funding_agency), as: :json
    assert_response :success
  end

  test "should update funding_agency" do
    patch funding_agency_url(@funding_agency), params: { funding_agency: { name: @funding_agency.name } }, as: :json
    assert_response 200
  end

  test "should destroy funding_agency" do
    assert_difference('FundingAgency.count', -1) do
      delete funding_agency_url(@funding_agency), as: :json
    end

    assert_response 204
  end
end
