class PostgraduateProgramsController < ApplicationController
  before_action :set_postgraduate_program, only: [:show, :update, :destroy]

  # GET /postgraduate_programs
  def index
    @postgraduate_programs = PostgraduateProgram.all

    render json: @postgraduate_programs
  end

  # GET /postgraduate_programs/1
  def show
    render json: @postgraduate_program
  end

  # POST /postgraduate_programs
  def create
    @postgraduate_program = PostgraduateProgram.new(postgraduate_program_params)

    if @postgraduate_program.save
      render json: @postgraduate_program, status: :created, location: @postgraduate_program
    else
      render json: @postgraduate_program.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /postgraduate_programs/1
  def update
    if @postgraduate_program.update(postgraduate_program_params)
      render json: @postgraduate_program
    else
      render json: @postgraduate_program.errors, status: :unprocessable_entity
    end
  end

  # DELETE /postgraduate_programs/1
  def destroy
    @postgraduate_program.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_postgraduate_program
      @postgraduate_program = PostgraduateProgram.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def postgraduate_program_params
      params.permit(:name, :course_degree_id, :institution_id)
    end
end
