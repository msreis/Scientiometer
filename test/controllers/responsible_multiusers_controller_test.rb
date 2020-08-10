require 'test_helper'

class ResponsibleMultiusersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @responsible_multiuser = responsible_multiusers(:one)
  end

  test "should get index" do
    get responsible_multiusers_url, as: :json
    assert_response :success
  end

  test "should create responsible_multiuser" do
    assert_difference('ResponsibleMultiuser.count') do
      post responsible_multiusers_url, params: { responsible_multiuser: { multiuser_id: @responsible_multiuser.multiuser_id, researcher_id: @responsible_multiuser.researcher_id, year: @responsible_multiuser.year } }, as: :json
    end

    assert_response 201
  end

  test "should show responsible_multiuser" do
    get responsible_multiuser_url(@responsible_multiuser), as: :json
    assert_response :success
  end

  test "should update responsible_multiuser" do
    patch responsible_multiuser_url(@responsible_multiuser), params: { responsible_multiuser: { multiuser_id: @responsible_multiuser.multiuser_id, researcher_id: @responsible_multiuser.researcher_id, year: @responsible_multiuser.year } }, as: :json
    assert_response 200
  end

  test "should destroy responsible_multiuser" do
    assert_difference('ResponsibleMultiuser.count', -1) do
      delete responsible_multiuser_url(@responsible_multiuser), as: :json
    end

    assert_response 204
  end
end
