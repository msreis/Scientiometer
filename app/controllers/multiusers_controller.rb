class MultiusersController < ApplicationController
  before_action :set_multiuser, only: [:show, :update, :destroy]

  # GET /multiusers
  def index
    @multiusers = Multiuser.all

    render json: @multiusers
  end

  # GET /multiusers/1
  def show
    render json: @multiuser
  end

  # POST /multiusers
  def create
    @multiuser = Multiuser.new(multiuser_params)

    if @multiuser.save
      render json: @multiuser, status: :created, location: @multiuser
    else
      render json: @multiuser.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /multiusers/1
  def update
    if @multiuser.update(multiuser_params)
      render json: @multiuser
    else
      render json: @multiuser.errors, status: :unprocessable_entity
    end
  end

  # DELETE /multiusers/1
  def destroy
    @multiuser.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_multiuser
      @multiuser = Multiuser.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def multiuser_params
      params.permit(:model, :manufacturer, :description, :location)
    end
end
