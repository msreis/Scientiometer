require 'test_helper'

class CongressesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @congress = congresses(:one)
  end

  test "should get index" do
    get congresses_url, as: :json
    assert_response :success
  end

  test "should create congress" do
    assert_difference('Congress.count') do
      post congresses_url, params: { congress: { country: @congress.country, name: @congress.name } }, as: :json
    end

    assert_response 201
  end

  test "should show congress" do
    get congress_url(@congress), as: :json
    assert_response :success
  end

  test "should update congress" do
    patch congress_url(@congress), params: { congress: { country: @congress.country, name: @congress.name } }, as: :json
    assert_response 200
  end

  test "should destroy congress" do
    assert_difference('Congress.count', -1) do
      delete congress_url(@congress), as: :json
    end

    assert_response 204
  end
end
