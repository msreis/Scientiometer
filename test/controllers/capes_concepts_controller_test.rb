require 'test_helper'

class CapesConceptsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @capes_concept = capes_concepts(:one)
  end

  test "should get index" do
    get capes_concepts_url, as: :json
    assert_response :success
  end

  test "should create capes_concept" do
    assert_difference('CapesConcept.count') do
      post capes_concepts_url, params: { capes_concept: { concept: @capes_concept.concept } }, as: :json
    end

    assert_response 201
  end

  test "should show capes_concept" do
    get capes_concept_url(@capes_concept), as: :json
    assert_response :success
  end

  test "should update capes_concept" do
    patch capes_concept_url(@capes_concept), params: { capes_concept: { concept: @capes_concept.concept } }, as: :json
    assert_response 200
  end

  test "should destroy capes_concept" do
    assert_difference('CapesConcept.count', -1) do
      delete capes_concept_url(@capes_concept), as: :json
    end

    assert_response 204
  end
end
