class FbLevelsController < ApplicationController
  before_action :set_fb_level, only: [:show, :update, :destroy]

  # GET /fb_levels
  def index
    @fb_levels = FbLevel.all

    render json: @fb_levels
  end

  # GET /fb_levels/1
  def show
    render json: @fb_level
  end

  # POST /fb_levels
  def create
    @fb_level = FbLevel.new(fb_level_params)

    if @fb_level.save
      render json: @fb_level, status: :created, location: @fb_level
    else
      render json: @fb_level.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /fb_levels/1
  def update
    if @fb_level.update(fb_level_params)
      render json: @fb_level
    else
      render json: @fb_level.errors, status: :unprocessable_entity
    end
  end

  # DELETE /fb_levels/1
  def destroy
    @fb_level.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fb_level
      @fb_level = FbLevel.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def fb_level_params
      params.permit(:level)
    end
end
