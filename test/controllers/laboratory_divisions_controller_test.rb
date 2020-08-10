require 'test_helper'

class LaboratoryDivisionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @laboratory_division = laboratory_divisions(:one)
  end

  test "should get index" do
    get laboratory_divisions_url, as: :json
    assert_response :success
  end

  test "should create laboratory_division" do
    assert_difference('LaboratoryDivision.count') do
      post laboratory_divisions_url, params: { laboratory_division: { name: @laboratory_division.name } }, as: :json
    end

    assert_response 201
  end

  test "should show laboratory_division" do
    get laboratory_division_url(@laboratory_division), as: :json
    assert_response :success
  end

  test "should update laboratory_division" do
    patch laboratory_division_url(@laboratory_division), params: { laboratory_division: { name: @laboratory_division.name } }, as: :json
    assert_response 200
  end

  test "should destroy laboratory_division" do
    assert_difference('LaboratoryDivision.count', -1) do
      delete laboratory_division_url(@laboratory_division), as: :json
    end

    assert_response 204
  end
end
