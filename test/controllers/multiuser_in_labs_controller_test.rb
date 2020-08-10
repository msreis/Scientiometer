require 'test_helper'

class MultiuserInLabsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @multiuser_in_lab = multiuser_in_labs(:one)
  end

  test "should get index" do
    get multiuser_in_labs_url, as: :json
    assert_response :success
  end

  test "should create multiuser_in_lab" do
    assert_difference('MultiuserInLab.count') do
      post multiuser_in_labs_url, params: { multiuser_in_lab: { laboratory_id: @multiuser_in_lab.laboratory_id, multiuser_id: @multiuser_in_lab.multiuser_id, year: @multiuser_in_lab.year } }, as: :json
    end

    assert_response 201
  end

  test "should show multiuser_in_lab" do
    get multiuser_in_lab_url(@multiuser_in_lab), as: :json
    assert_response :success
  end

  test "should update multiuser_in_lab" do
    patch multiuser_in_lab_url(@multiuser_in_lab), params: { multiuser_in_lab: { laboratory_id: @multiuser_in_lab.laboratory_id, multiuser_id: @multiuser_in_lab.multiuser_id, year: @multiuser_in_lab.year } }, as: :json
    assert_response 200
  end

  test "should destroy multiuser_in_lab" do
    assert_difference('MultiuserInLab.count', -1) do
      delete multiuser_in_lab_url(@multiuser_in_lab), as: :json
    end

    assert_response 204
  end
end
