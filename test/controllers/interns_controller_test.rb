require 'test_helper'

class InternsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @intern = interns(:one)
  end

  test "should get index" do
    get interns_url, as: :json
    assert_response :success
  end

  test "should create intern" do
    assert_difference('Intern.count') do
      post interns_url, params: { intern: { name: @intern.name } }, as: :json
    end

    assert_response 201
  end

  test "should show intern" do
    get intern_url(@intern), as: :json
    assert_response :success
  end

  test "should update intern" do
    patch intern_url(@intern), params: { intern: { name: @intern.name } }, as: :json
    assert_response 200
  end

  test "should destroy intern" do
    assert_difference('Intern.count', -1) do
      delete intern_url(@intern), as: :json
    end

    assert_response 204
  end
end
