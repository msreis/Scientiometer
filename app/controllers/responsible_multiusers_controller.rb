class ResponsibleMultiusersController < ApplicationController
  before_action :set_responsible_multiuser, only: [:show, :update, :destroy]

  # GET /responsible_multiusers
  def index
    @responsible_multiusers = ResponsibleMultiuser.all

    render json: @responsible_multiusers
  end

  # GET /responsible_multiusers/1
  def show
    render json: @responsible_multiuser
  end

  # POST /responsible_multiusers
  def create
    @responsible_multiuser = ResponsibleMultiuser.new(responsible_multiuser_params)

    if @responsible_multiuser.save
      render json: @responsible_multiuser, status: :created, location: @responsible_multiuser
    else
      render json: @responsible_multiuser.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /responsible_multiusers/1
  def update
    if @responsible_multiuser.update(responsible_multiuser_params)
      render json: @responsible_multiuser
    else
      render json: @responsible_multiuser.errors, status: :unprocessable_entity
    end
  end

  # DELETE /responsible_multiusers/1
  def destroy
    @responsible_multiuser.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_responsible_multiuser
      @responsible_multiuser = ResponsibleMultiuser.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def responsible_multiuser_params
      params.permit(:researcher_id, :multiuser_id, :year)
    end
end
