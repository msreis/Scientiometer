require 'test_helper'

class MultiuserArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @multiuser_article = multiuser_articles(:one)
  end

  test "should get index" do
    get multiuser_articles_url, as: :json
    assert_response :success
  end

  test "should create multiuser_article" do
    assert_difference('MultiuserArticle.count') do
      post multiuser_articles_url, params: { multiuser_article: { article_id: @multiuser_article.article_id, multiuser_id: @multiuser_article.multiuser_id, year: @multiuser_article.year } }, as: :json
    end

    assert_response 201
  end

  test "should show multiuser_article" do
    get multiuser_article_url(@multiuser_article), as: :json
    assert_response :success
  end

  test "should update multiuser_article" do
    patch multiuser_article_url(@multiuser_article), params: { multiuser_article: { article_id: @multiuser_article.article_id, multiuser_id: @multiuser_article.multiuser_id, year: @multiuser_article.year } }, as: :json
    assert_response 200
  end

  test "should destroy multiuser_article" do
    assert_difference('MultiuserArticle.count', -1) do
      delete multiuser_article_url(@multiuser_article), as: :json
    end

    assert_response 204
  end
end
