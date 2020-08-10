require 'test_helper'

class ResearchersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @researcher = researchers(:one)
  end

  test "should get index" do
    get researchers_url, as: :json
    assert_response :success
  end

  test "should create researcher" do
    assert_difference('Researcher.count') do
      post researchers_url, params: { researcher: { ORCID: @researcher.ORCID, code: @researcher.code, email: @researcher.email, employee_id: @researcher.employee_id, ingress_date: @researcher.ingress_date, is_lab_director: @researcher.is_lab_director, researcher_id: @researcher.researcher_id } }, as: :json
    end

    assert_response 201
  end

  test "should show researcher" do
    get researcher_url(@researcher), as: :json
    assert_response :success
  end

  test "should update researcher" do
    patch researcher_url(@researcher), params: { researcher: { ORCID: @researcher.ORCID, code: @researcher.code, email: @researcher.email, employee_id: @researcher.employee_id, ingress_date: @researcher.ingress_date, is_lab_director: @researcher.is_lab_director, researcher_id: @researcher.researcher_id } }, as: :json
    assert_response 200
  end

  test "should destroy researcher" do
    assert_difference('Researcher.count', -1) do
      delete researcher_url(@researcher), as: :json
    end

    assert_response 204
  end
end
