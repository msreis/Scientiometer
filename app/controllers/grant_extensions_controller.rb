class GrantExtensionsController < ApplicationController
  before_action :set_grant_extension, only: [:show, :update, :destroy]

  # GET /grant_extensions
  def index
    @grant_extensions = GrantExtension.all

    render json: @grant_extensions
  end

  # GET /grant_extensions/1
  def show
    render json: @grant_extension
  end

  # POST /grant_extensions
  def create
    @grant_extension = GrantExtension.new(grant_extension_params)

    if @grant_extension.save
      render json: @grant_extension, status: :created, location: @grant_extension
    else
      render json: @grant_extension.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /grant_extensions/1
  def update
    if @grant_extension.update(grant_extension_params)
      render json: @grant_extension
    else
      render json: @grant_extension.errors, status: :unprocessable_entity
    end
  end

  # DELETE /grant_extensions/1
  def destroy
    @grant_extension.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grant_extension
      @grant_extension = GrantExtension.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def grant_extension_params
      params.permit(:grant_id, :value_BRL, :value_USD, :validity_start, :validity_end)
    end
end
