require 'test_helper'

class CnpqLevelsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cnpq_level = cnpq_levels(:one)
  end

  test "should get index" do
    get cnpq_levels_url, as: :json
    assert_response :success
  end

  test "should create cnpq_level" do
    assert_difference('CnpqLevel.count') do
      post cnpq_levels_url, params: { cnpq_level: { level: @cnpq_level.level } }, as: :json
    end

    assert_response 201
  end

  test "should show cnpq_level" do
    get cnpq_level_url(@cnpq_level), as: :json
    assert_response :success
  end

  test "should update cnpq_level" do
    patch cnpq_level_url(@cnpq_level), params: { cnpq_level: { level: @cnpq_level.level } }, as: :json
    assert_response 200
  end

  test "should destroy cnpq_level" do
    assert_difference('CnpqLevel.count', -1) do
      delete cnpq_level_url(@cnpq_level), as: :json
    end

    assert_response 204
  end
end
