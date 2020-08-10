require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article = articles(:one)
  end

  test "should get index" do
    get articles_url, as: :json
    assert_response :success
  end

  test "should create article" do
    assert_difference('Article.count') do
      post articles_url, params: { article: { DOI_url: @article.DOI_url, collaboration_type_id: @article.collaboration_type_id, impact_factor: @article.impact_factor, qualis_id: @article.qualis_id, reference: @article.reference, year: @article.year } }, as: :json
    end

    assert_response 201
  end

  test "should show article" do
    get article_url(@article), as: :json
    assert_response :success
  end

  test "should update article" do
    patch article_url(@article), params: { article: { DOI_url: @article.DOI_url, collaboration_type_id: @article.collaboration_type_id, impact_factor: @article.impact_factor, qualis_id: @article.qualis_id, reference: @article.reference, year: @article.year } }, as: :json
    assert_response 200
  end

  test "should destroy article" do
    assert_difference('Article.count', -1) do
      delete article_url(@article), as: :json
    end

    assert_response 204
  end
end
