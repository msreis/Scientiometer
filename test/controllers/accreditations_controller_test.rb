require 'test_helper'

class AccreditationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @accreditation = accreditations(:one)
  end

  test "should get index" do
    get accreditations_url, as: :json
    assert_response :success
  end

  test "should create accreditation" do
    assert_difference('Accreditation.count') do
      post accreditations_url, params: { accreditation: { institution_id: @accreditation.institution_id, postgraduate_program_id: @accreditation.postgraduate_program_id, researcher_id: @accreditation.researcher_id, year: @accreditation.year } }, as: :json
    end

    assert_response 201
  end

  test "should show accreditation" do
    get accreditation_url(@accreditation), as: :json
    assert_response :success
  end

  test "should update accreditation" do
    patch accreditation_url(@accreditation), params: { accreditation: { institution_id: @accreditation.institution_id, postgraduate_program_id: @accreditation.postgraduate_program_id, researcher_id: @accreditation.researcher_id, year: @accreditation.year } }, as: :json
    assert_response 200
  end

  test "should destroy accreditation" do
    assert_difference('Accreditation.count', -1) do
      delete accreditation_url(@accreditation), as: :json
    end

    assert_response 204
  end
end
