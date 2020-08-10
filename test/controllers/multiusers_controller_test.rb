require 'test_helper'

class MultiusersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @multiuser = multiusers(:one)
  end

  test "should get index" do
    get multiusers_url, as: :json
    assert_response :success
  end

  test "should create multiuser" do
    assert_difference('Multiuser.count') do
      post multiusers_url, params: { multiuser: { description: @multiuser.description, location: @multiuser.location, manufacturer: @multiuser.manufacturer, model: @multiuser.model } }, as: :json
    end

    assert_response 201
  end

  test "should show multiuser" do
    get multiuser_url(@multiuser), as: :json
    assert_response :success
  end

  test "should update multiuser" do
    patch multiuser_url(@multiuser), params: { multiuser: { description: @multiuser.description, location: @multiuser.location, manufacturer: @multiuser.manufacturer, model: @multiuser.model } }, as: :json
    assert_response 200
  end

  test "should destroy multiuser" do
    assert_difference('Multiuser.count', -1) do
      delete multiuser_url(@multiuser), as: :json
    end

    assert_response 204
  end
end
