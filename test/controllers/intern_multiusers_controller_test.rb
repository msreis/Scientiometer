require 'test_helper'

class InternMultiusersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @intern_multiuser = intern_multiusers(:one)
  end

  test "should get index" do
    get intern_multiusers_url, as: :json
    assert_response :success
  end

  test "should create intern_multiuser" do
    assert_difference('InternMultiuser.count') do
      post intern_multiusers_url, params: { intern_multiuser: { intern_id: @intern_multiuser.intern_id, multiuser_id: @intern_multiuser.multiuser_id, year: @intern_multiuser.year } }, as: :json
    end

    assert_response 201
  end

  test "should show intern_multiuser" do
    get intern_multiuser_url(@intern_multiuser), as: :json
    assert_response :success
  end

  test "should update intern_multiuser" do
    patch intern_multiuser_url(@intern_multiuser), params: { intern_multiuser: { intern_id: @intern_multiuser.intern_id, multiuser_id: @intern_multiuser.multiuser_id, year: @intern_multiuser.year } }, as: :json
    assert_response 200
  end

  test "should destroy intern_multiuser" do
    assert_difference('InternMultiuser.count', -1) do
      delete intern_multiuser_url(@intern_multiuser), as: :json
    end

    assert_response 204
  end
end
