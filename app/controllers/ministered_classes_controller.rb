class MinisteredClassesController < ApplicationController
  before_action :set_ministered_class, only: [:show, :update, :destroy]

  # GET /ministered_classes
  def index
    @ministered_classes = MinisteredClass.all

    render json: @ministered_classes
  end

  # GET /ministered_classes/1
  def show
    render json: @ministered_class
  end

  # POST /ministered_classes
  def create
    @ministered_class = MinisteredClass.new(ministered_class_params)

    if @ministered_class.save
      render json: @ministered_class, status: :created, location: @ministered_class
    else
      render json: @ministered_class.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /ministered_classes/1
  def update
    if @ministered_class.update(ministered_class_params)
      render json: @ministered_class
    else
      render json: @ministered_class.errors, status: :unprocessable_entity
    end
  end

  # DELETE /ministered_classes/1
  def destroy
    @ministered_class.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ministered_class
      @ministered_class = MinisteredClass.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def ministered_class_params
      params.permit(:postgraduate_program_id, :institution_id, :subject_id, :year)
    end
end
