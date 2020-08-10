require 'test_helper'

class CongressParticipationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @congress_participation = congress_participations(:one)
  end

  test "should get index" do
    get congress_participations_url, as: :json
    assert_response :success
  end

  test "should create congress_participation" do
    assert_difference('CongressParticipation.count') do
      post congress_participations_url, params: { congress_participation: { congress_id: @congress_participation.congress_id, congress_role_id: @congress_participation.congress_role_id, researcher_id: @congress_participation.researcher_id, year: @congress_participation.year } }, as: :json
    end

    assert_response 201
  end

  test "should show congress_participation" do
    get congress_participation_url(@congress_participation), as: :json
    assert_response :success
  end

  test "should update congress_participation" do
    patch congress_participation_url(@congress_participation), params: { congress_participation: { congress_id: @congress_participation.congress_id, congress_role_id: @congress_participation.congress_role_id, researcher_id: @congress_participation.researcher_id, year: @congress_participation.year } }, as: :json
    assert_response 200
  end

  test "should destroy congress_participation" do
    assert_difference('CongressParticipation.count', -1) do
      delete congress_participation_url(@congress_participation), as: :json
    end

    assert_response 204
  end
end
