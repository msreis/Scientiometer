class CongressesController < ApplicationController
  before_action :set_congress, only: [:show, :update, :destroy]

  # GET /congresses
  def index
    @congresses = Congress.all

    render json: @congresses
  end

  # GET /congresses/1
  def show
    render json: @congress
  end

  # POST /congresses
  def create
    @congress = Congress.new(congress_params)

    if @congress.save
      render json: @congress, status: :created, location: @congress
    else
      render json: @congress.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /congresses/1
  def update
    if @congress.update(congress_params)
      render json: @congress
    else
      render json: @congress.errors, status: :unprocessable_entity
    end
  end

  # DELETE /congresses/1
  def destroy
    @congress.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_congress
      @congress = Congress.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def congress_params
      params.permit(:name, :country)
    end
end
