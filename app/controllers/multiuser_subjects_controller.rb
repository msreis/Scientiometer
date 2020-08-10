class MultiuserSubjectsController < ApplicationController
  before_action :set_multiuser_subject, only: [:show, :update, :destroy]

  # GET /multiuser_subjects
  def index
    @multiuser_subjects = MultiuserSubject.all

    render json: @multiuser_subjects
  end

  # GET /multiuser_subjects/1
  def show
    render json: @multiuser_subject
  end

  # POST /multiuser_subjects
  def create
    @multiuser_subject = MultiuserSubject.new(multiuser_subject_params)

    if @multiuser_subject.save
      render json: @multiuser_subject, status: :created, location: @multiuser_subject
    else
      render json: @multiuser_subject.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /multiuser_subjects/1
  def update
    if @multiuser_subject.update(multiuser_subject_params)
      render json: @multiuser_subject
    else
      render json: @multiuser_subject.errors, status: :unprocessable_entity
    end
  end

  # DELETE /multiuser_subjects/1
  def destroy
    @multiuser_subject.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_multiuser_subject
      @multiuser_subject = MultiuserSubject.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def multiuser_subject_params
      params.permit(:subject_id, :multiuser_id, :year)
    end
end
