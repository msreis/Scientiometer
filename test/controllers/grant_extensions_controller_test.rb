require 'test_helper'

class GrantExtensionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @grant_extension = grant_extensions(:one)
  end

  test "should get index" do
    get grant_extensions_url, as: :json
    assert_response :success
  end

  test "should create grant_extension" do
    assert_difference('GrantExtension.count') do
      post grant_extensions_url, params: { grant_extension: { grant_id: @grant_extension.grant_id, validity_end: @grant_extension.validity_end, validity_start: @grant_extension.validity_start, value_BRL: @grant_extension.value_BRL, value_USD: @grant_extension.value_USD } }, as: :json
    end

    assert_response 201
  end

  test "should show grant_extension" do
    get grant_extension_url(@grant_extension), as: :json
    assert_response :success
  end

  test "should update grant_extension" do
    patch grant_extension_url(@grant_extension), params: { grant_extension: { grant_id: @grant_extension.grant_id, validity_end: @grant_extension.validity_end, validity_start: @grant_extension.validity_start, value_BRL: @grant_extension.value_BRL, value_USD: @grant_extension.value_USD } }, as: :json
    assert_response 200
  end

  test "should destroy grant_extension" do
    assert_difference('GrantExtension.count', -1) do
      delete grant_extension_url(@grant_extension), as: :json
    end

    assert_response 204
  end
end
