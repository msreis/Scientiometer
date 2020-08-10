class MultiuserArticlesController < ApplicationController
  before_action :set_multiuser_article, only: [:show, :update, :destroy]

  # GET /multiuser_articles
  def index
    @multiuser_articles = MultiuserArticle.all

    render json: @multiuser_articles
  end

  # GET /multiuser_articles/1
  def show
    render json: @multiuser_article
  end

  # POST /multiuser_articles
  def create
    @multiuser_article = MultiuserArticle.new(multiuser_article_params)

    if @multiuser_article.save
      render json: @multiuser_article, status: :created, location: @multiuser_article
    else
      render json: @multiuser_article.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /multiuser_articles/1
  def update
    if @multiuser_article.update(multiuser_article_params)
      render json: @multiuser_article
    else
      render json: @multiuser_article.errors, status: :unprocessable_entity
    end
  end

  # DELETE /multiuser_articles/1
  def destroy
    @multiuser_article.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_multiuser_article
      @multiuser_article = MultiuserArticle.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def multiuser_article_params
      params.permit(:article_id, :multiuser_id, :year)
    end
end
