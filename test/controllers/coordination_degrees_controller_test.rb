require 'test_helper'

class CoordinationDegreesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @coordination_degree = coordination_degrees(:one)
  end

  test "should get index" do
    get coordination_degrees_url, as: :json
    assert_response :success
  end

  test "should create coordination_degree" do
    assert_difference('CoordinationDegree.count') do
      post coordination_degrees_url, params: { coordination_degree: { degree: @coordination_degree.degree } }, as: :json
    end

    assert_response 201
  end

  test "should show coordination_degree" do
    get coordination_degree_url(@coordination_degree), as: :json
    assert_response :success
  end

  test "should update coordination_degree" do
    patch coordination_degree_url(@coordination_degree), params: { coordination_degree: { degree: @coordination_degree.degree } }, as: :json
    assert_response 200
  end

  test "should destroy coordination_degree" do
    assert_difference('CoordinationDegree.count', -1) do
      delete coordination_degree_url(@coordination_degree), as: :json
    end

    assert_response 204
  end
end
