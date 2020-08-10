require 'test_helper'

class PostdocsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @postdoc = postdocs(:one)
  end

  test "should get index" do
    get postdocs_url, as: :json
    assert_response :success
  end

  test "should create postdoc" do
    assert_difference('Postdoc.count') do
      post postdocs_url, params: { postdoc: { name: @postdoc.name } }, as: :json
    end

    assert_response 201
  end

  test "should show postdoc" do
    get postdoc_url(@postdoc), as: :json
    assert_response :success
  end

  test "should update postdoc" do
    patch postdoc_url(@postdoc), params: { postdoc: { name: @postdoc.name } }, as: :json
    assert_response 200
  end

  test "should destroy postdoc" do
    assert_difference('Postdoc.count', -1) do
      delete postdoc_url(@postdoc), as: :json
    end

    assert_response 204
  end
end
