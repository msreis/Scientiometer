class PostdocsController < ApplicationController
  before_action :set_postdoc, only: [:show, :update, :destroy]

  # GET /postdocs
  def index
    @postdocs = Postdoc.all

    render json: @postdocs
  end

  # GET /postdocs/1
  def show
    render json: @postdoc
  end

  # POST /postdocs
  def create
    @postdoc = Postdoc.new(postdoc_params)

    if @postdoc.save
      render json: @postdoc, status: :created, location: @postdoc
    else
      render json: @postdoc.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /postdocs/1
  def update
    if @postdoc.update(postdoc_params)
      render json: @postdoc
    else
      render json: @postdoc.errors, status: :unprocessable_entity
    end
  end

  # DELETE /postdocs/1
  def destroy
    @postdoc.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_postdoc
      @postdoc = Postdoc.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def postdoc_params
      params.require(:postdoc).permit(:name)
    end
end
