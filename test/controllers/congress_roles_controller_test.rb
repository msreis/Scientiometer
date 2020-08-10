require 'test_helper'

class CongressRolesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @congress_role = congress_roles(:one)
  end

  test "should get index" do
    get congress_roles_url, as: :json
    assert_response :success
  end

  test "should create congress_role" do
    assert_difference('CongressRole.count') do
      post congress_roles_url, params: { congress_role: { role: @congress_role.role } }, as: :json
    end

    assert_response 201
  end

  test "should show congress_role" do
    get congress_role_url(@congress_role), as: :json
    assert_response :success
  end

  test "should update congress_role" do
    patch congress_role_url(@congress_role), params: { congress_role: { role: @congress_role.role } }, as: :json
    assert_response 200
  end

  test "should destroy congress_role" do
    assert_difference('CongressRole.count', -1) do
      delete congress_role_url(@congress_role), as: :json
    end

    assert_response 204
  end
end
