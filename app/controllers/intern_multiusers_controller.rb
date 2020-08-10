class InternMultiusersController < ApplicationController
  before_action :set_intern_multiuser, only: [:show, :update, :destroy]

  # GET /intern_multiusers
  def index
    @intern_multiusers = InternMultiuser.all

    render json: @intern_multiusers
  end

  # GET /intern_multiusers/1
  def show
    render json: @intern_multiuser
  end

  # POST /intern_multiusers
  def create
    @intern_multiuser = InternMultiuser.new(intern_multiuser_params)

    if @intern_multiuser.save
      render json: @intern_multiuser, status: :created, location: @intern_multiuser
    else
      render json: @intern_multiuser.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /intern_multiusers/1
  def update
    if @intern_multiuser.update(intern_multiuser_params)
      render json: @intern_multiuser
    else
      render json: @intern_multiuser.errors, status: :unprocessable_entity
    end
  end

  # DELETE /intern_multiusers/1
  def destroy
    @intern_multiuser.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_intern_multiuser
      @intern_multiuser = InternMultiuser.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def intern_multiuser_params
      params.permit(:intern_id, :multiuser_id, :year)
    end
end
