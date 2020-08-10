require 'test_helper'

class AdvisementDegreesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @advisement_degree = advisement_degrees(:one)
  end

  test "should get index" do
    get advisement_degrees_url, as: :json
    assert_response :success
  end

  test "should create advisement_degree" do
    assert_difference('AdvisementDegree.count') do
      post advisement_degrees_url, params: { advisement_degree: { degree: @advisement_degree.degree } }, as: :json
    end

    assert_response 201
  end

  test "should show advisement_degree" do
    get advisement_degree_url(@advisement_degree), as: :json
    assert_response :success
  end

  test "should update advisement_degree" do
    patch advisement_degree_url(@advisement_degree), params: { advisement_degree: { degree: @advisement_degree.degree } }, as: :json
    assert_response 200
  end

  test "should destroy advisement_degree" do
    assert_difference('AdvisementDegree.count', -1) do
      delete advisement_degree_url(@advisement_degree), as: :json
    end

    assert_response 204
  end
end
