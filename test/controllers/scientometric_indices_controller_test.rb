require 'test_helper'

class ScientometricIndicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @scientometric_index = scientometric_indices(:one)
  end

  test "should get index" do
    get scientometric_indices_url, as: :json
    assert_response :success
  end

  test "should create scientometric_index" do
    assert_difference('ScientometricIndex.count') do
      post scientometric_indices_url, params: { scientometric_index: { citations_gs: @scientometric_index.citations_gs, citations_wos: @scientometric_index.citations_wos, h_index_gs: @scientometric_index.h_index_gs, h_index_wos: @scientometric_index.h_index_wos, researcher_id: @scientometric_index.researcher_id, year: @scientometric_index.year } }, as: :json
    end

    assert_response 201
  end

  test "should show scientometric_index" do
    get scientometric_index_url(@scientometric_index), as: :json
    assert_response :success
  end

  test "should update scientometric_index" do
    patch scientometric_index_url(@scientometric_index), params: { scientometric_index: { citations_gs: @scientometric_index.citations_gs, citations_wos: @scientometric_index.citations_wos, h_index_gs: @scientometric_index.h_index_gs, h_index_wos: @scientometric_index.h_index_wos, researcher_id: @scientometric_index.researcher_id, year: @scientometric_index.year } }, as: :json
    assert_response 200
  end

  test "should destroy scientometric_index" do
    assert_difference('ScientometricIndex.count', -1) do
      delete scientometric_index_url(@scientometric_index), as: :json
    end

    assert_response 204
  end
end
