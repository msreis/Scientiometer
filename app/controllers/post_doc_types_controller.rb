class PostDocTypesController < ApplicationController
  before_action :set_post_doc_type, only: [:show, :update, :destroy]

  # GET /post_doc_types
  def index
    @post_doc_types = PostDocType.all

    render json: @post_doc_types
  end

  # GET /post_doc_types/1
  def show
    render json: @post_doc_type
  end

  # POST /post_doc_types
  def create
    @post_doc_type = PostDocType.new(post_doc_type_params)

    if @post_doc_type.save
      render json: @post_doc_type, status: :created, location: @post_doc_type
    else
      render json: @post_doc_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /post_doc_types/1
  def update
    if @post_doc_type.update(post_doc_type_params)
      render json: @post_doc_type
    else
      render json: @post_doc_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /post_doc_types/1
  def destroy
    @post_doc_type.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post_doc_type
      @post_doc_type = PostDocType.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def post_doc_type_params
      params.permit(:type)
    end
end
