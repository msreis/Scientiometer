require 'test_helper'

class PostDocTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post_doc_type = post_doc_types(:one)
  end

  test "should get index" do
    get post_doc_types_url, as: :json
    assert_response :success
  end

  test "should create post_doc_type" do
    assert_difference('PostDocType.count') do
      post post_doc_types_url, params: { post_doc_type: { postdoc_type: @post_doc_type.postdoc_type } }, as: :json
    end

    assert_response 201
  end

  test "should show post_doc_type" do
    get post_doc_type_url(@post_doc_type), as: :json
    assert_response :success
  end

  test "should update post_doc_type" do
    patch post_doc_type_url(@post_doc_type), params: { post_doc_type: { postdoc_type: @post_doc_type.postdoc_type } }, as: :json
    assert_response 200
  end

  test "should destroy post_doc_type" do
    assert_difference('PostDocType.count', -1) do
      delete post_doc_type_url(@post_doc_type), as: :json
    end

    assert_response 204
  end
end
