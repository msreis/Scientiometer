require 'test_helper'

class LaboratoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @laboratory = laboratories(:one)
  end

  test "should get index" do
    get laboratories_url, as: :json
    assert_response :success
  end

  test "should create laboratory" do
    assert_difference('Laboratory.count') do
      post laboratories_url, params: { laboratory: { laboratory_division_id: @laboratory.laboratory_division_id, name: @laboratory.name } }, as: :json
    end

    assert_response 201
  end

  test "should show laboratory" do
    get laboratory_url(@laboratory), as: :json
    assert_response :success
  end

  test "should update laboratory" do
    patch laboratory_url(@laboratory), params: { laboratory: { laboratory_division_id: @laboratory.laboratory_division_id, name: @laboratory.name } }, as: :json
    assert_response 200
  end

  test "should destroy laboratory" do
    assert_difference('Laboratory.count', -1) do
      delete laboratory_url(@laboratory), as: :json
    end

    assert_response 204
  end
end
