class QualisController < ApplicationController
  # Rails has some problemas to automatically create controllers for plural
  # names, so some of them are still incorrectly singular

  before_action :set_quali, only: [:show, :update, :destroy]

  # GET /qualis
  def index
    @qualis = Qualis.all

    render json: @qualis
  end

  # GET /qualis/1
  def show
    render json: @quali
  end

  # POST /qualis
  def create
    @quali = Qualis.new(quali_params)

    if @quali.save
      render json: @quali, status: :created, location: @quali
    else
      render json: @quali.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /qualis/1
  def update
    if @quali.update(quali_params)
      render json: @quali
    else
      render json: @quali.errors, status: :unprocessable_entity
    end
  end

  # DELETE /qualis/1
  def destroy
    @quali.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quali
      @quali = Qualis.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def quali_params
      params.permit(:tier)
    end
end
