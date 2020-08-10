require 'test_helper'

class ScholarshipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @scholarship = scholarships(:one)
  end

  test "should get index" do
    get scholarships_url, as: :json
    assert_response :success
  end

  test "should create scholarship" do
    assert_difference('Scholarship.count') do
      post scholarships_url, params: { scholarship: { advisement_id: @scholarship.advisement_id, funding_agency_id: @scholarship.funding_agency_id, process_number: @scholarship.process_number, technical_reserve_BRL: @scholarship.technical_reserve_BRL, total_value_BRL: @scholarship.total_value_BRL, total_value_USD: @scholarship.total_value_USD, validity_end: @scholarship.validity_end, validity_start: @scholarship.validity_start } }, as: :json
    end

    assert_response 201
  end

  test "should show scholarship" do
    get scholarship_url(@scholarship), as: :json
    assert_response :success
  end

  test "should update scholarship" do
    patch scholarship_url(@scholarship), params: { scholarship: { advisement_id: @scholarship.advisement_id, funding_agency_id: @scholarship.funding_agency_id, process_number: @scholarship.process_number, technical_reserve_BRL: @scholarship.technical_reserve_BRL, total_value_BRL: @scholarship.total_value_BRL, total_value_USD: @scholarship.total_value_USD, validity_end: @scholarship.validity_end, validity_start: @scholarship.validity_start } }, as: :json
    assert_response 200
  end

  test "should destroy scholarship" do
    assert_difference('Scholarship.count', -1) do
      delete scholarship_url(@scholarship), as: :json
    end

    assert_response 204
  end
end
