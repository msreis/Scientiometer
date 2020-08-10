require 'test_helper'

class MultiuserThesesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @multiuser_thesis = multiuser_theses(:one)
  end

  test "should get index" do
    get multiuser_theses_url, as: :json
    assert_response :success
  end

  test "should create multiuser_thesis" do
    assert_difference('MultiuserThesis.count') do
      post multiuser_theses_url, params: { multiuser_thesis: { multiuser_id: @multiuser_thesis.multiuser_id, thesis_id: @multiuser_thesis.thesis_id, year: @multiuser_thesis.year } }, as: :json
    end

    assert_response 201
  end

  test "should show multiuser_thesis" do
    get multiuser_thesis_url(@multiuser_thesis), as: :json
    assert_response :success
  end

  test "should update multiuser_thesis" do
    patch multiuser_thesis_url(@multiuser_thesis), params: { multiuser_thesis: { multiuser_id: @multiuser_thesis.multiuser_id, thesis_id: @multiuser_thesis.thesis_id, year: @multiuser_thesis.year } }, as: :json
    assert_response 200
  end

  test "should destroy multiuser_thesis" do
    assert_difference('MultiuserThesis.count', -1) do
      delete multiuser_thesis_url(@multiuser_thesis), as: :json
    end

    assert_response 204
  end
end
