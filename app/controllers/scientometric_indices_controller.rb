class ScientometricIndicesController < ApplicationController
  before_action :set_scientometric_index, only: [:show, :update, :destroy]

  # GET /scientometric_indices
  def index
    @scientometric_indices = ScientometricIndex.all

    render json: @scientometric_indices
  end

  # GET /scientometric_indices/1
  def show
    render json: @scientometric_index
  end

  # POST /scientometric_indices
  def create
    @scientometric_index = ScientometricIndex.new(scientometric_index_params)

    if @scientometric_index.save
      render json: @scientometric_index, status: :created, location: @scientometric_index
    else
      render json: @scientometric_index.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /scientometric_indices/1
  def update
    if @scientometric_index.update(scientometric_index_params)
      render json: @scientometric_index
    else
      render json: @scientometric_index.errors, status: :unprocessable_entity
    end
  end

  # DELETE /scientometric_indices/1
  def destroy
    @scientometric_index.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scientometric_index
      @scientometric_index = ScientometricIndex.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def scientometric_index_params
      params.permit(:citations_wos, :h_index_wos, :citations_gs, :h_index_gs, :researcher_id, :year)
    end
end
