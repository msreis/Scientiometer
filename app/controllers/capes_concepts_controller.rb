class CapesConceptsController < ApplicationController
  before_action :set_capes_concept, only: [:show, :update, :destroy]

  # GET /capes_concepts
  def index
    @capes_concepts = CapesConcept.all

    render json: @capes_concepts
  end

  # GET /capes_concepts/1
  def show
    render json: @capes_concept
  end

  # POST /capes_concepts
  def create
    @capes_concept = CapesConcept.new(capes_concept_params)

    if @capes_concept.save
      render json: @capes_concept, status: :created, location: @capes_concept
    else
      render json: @capes_concept.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /capes_concepts/1
  def update
    if @capes_concept.update(capes_concept_params)
      render json: @capes_concept
    else
      render json: @capes_concept.errors, status: :unprocessable_entity
    end
  end

  # DELETE /capes_concepts/1
  def destroy
    @capes_concept.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_capes_concept
      @capes_concept = CapesConcept.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def capes_concept_params
      params.require(:capes_concept).permit(:concept)
    end
end
