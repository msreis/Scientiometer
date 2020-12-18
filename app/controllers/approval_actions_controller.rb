class ApprovalActionsController < ApplicationController
  before_action :set_approval_action, only: [:show, :update, :destroy]

  # GET /approval_actions
  def index
    @approval_actions = ApprovalAction.all

    render json: @approval_actions
  end

  # GET /approval_actions/1
  def show
    render json: @approval_action
  end

  # POST /approval_actions
  def create
    @approval_action = ApprovalAction.new(approval_action_params)

    if @approval_action.save
      render json: @approval_action, status: :created, location: @approval_action
    else
      render json: @approval_action.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /approval_actions/1
  def update
    if @approval_action.update(approval_action_params)
      render json: @approval_action
    else
      render json: @approval_action.errors, status: :unprocessable_entity
    end
  end

  # DELETE /approval_actions/1
  def destroy
    @approval_action.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_approval_action
      @approval_action = ApprovalAction.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def approval_action_params
      params.require(:approval_action).permit(:name)
    end
end
