require 'test_helper'

class FbLevelsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @fb_level = fb_levels(:one)
  end

  test "should get index" do
    get fb_levels_url, as: :json
    assert_response :success
  end

  test "should create fb_level" do
    assert_difference('FbLevel.count') do
      post fb_levels_url, params: { fb_level: { level: @fb_level.level } }, as: :json
    end

    assert_response 201
  end

  test "should show fb_level" do
    get fb_level_url(@fb_level), as: :json
    assert_response :success
  end

  test "should update fb_level" do
    patch fb_level_url(@fb_level), params: { fb_level: { level: @fb_level.level } }, as: :json
    assert_response 200
  end

  test "should destroy fb_level" do
    assert_difference('FbLevel.count', -1) do
      delete fb_level_url(@fb_level), as: :json
    end

    assert_response 204
  end
end
