class ApprovalHistoriesController < ApplicationController
  before_action :set_approval_history, only: [:show, :update, :destroy]
  before_action :authorize_request, only: [:get_by_submission]

  # GET /approval_histories
  def index
    @approval_histories = ApprovalHistory.all

    render json: @approval_histories
  end

  # GET /approval_histories/1
  def show
    render json: @approval_history
  end

  # POST /approval_histories
  def create
    @approval_history = ApprovalHistory.new(approval_history_params)

    if @approval_history.save
      render json: @approval_history, status: :created, location: @approval_history
    else
      render json: @approval_history.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /approval_histories/1
  def update
    if @approval_history.update(approval_history_params)
      render json: @approval_history
    else
      render json: @approval_history.errors, status: :unprocessable_entity
    end
  end

  # DELETE /approval_histories/1
  def destroy
    @approval_history.destroy
  end

  # GET /approval_histories/submissions/1
  def get_by_submission
    histories = ApprovalHistory.where(submission_id: params[:id])
    ret = histories.map { |history| prepare(history)  }
    render json: ret, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_approval_history
      @approval_history = ApprovalHistory.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def approval_history_params
      params.require(:approval_history).permit(:account_id, :submission_id, :approval_action_id, :comment)
    end

    def prepare(history)
      puts history
      account = Account.find(history.account_id)
      employee = Employee.find(account.employee_id)
      action = ApprovalAction.find(history.approval_action_id)
      {id: history.id,
       created: history.created_at,
       account: employee.name,
       action: action.name,
       comment: history.comment
      }
    end
end
