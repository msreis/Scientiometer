class MultiuserActivitiesController < ApplicationController
  before_action :set_multiuser_activity, only: [:show, :update, :destroy]

  # GET /multiuser_activities
  def index
    @multiuser_activities = MultiuserActivity.all

    render json: @multiuser_activities
  end

  # GET /multiuser_activities/1
  def show
    render json: @multiuser_activity
  end

  # POST /multiuser_activities
  def create
    @multiuser_activity = MultiuserActivity.new(multiuser_activity_params)

    if @multiuser_activity.save
      render json: @multiuser_activity, status: :created, location: @multiuser_activity
    else
      render json: @multiuser_activity.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /multiuser_activities/1
  def update
    if @multiuser_activity.update(multiuser_activity_params)
      render json: @multiuser_activity
    else
      render json: @multiuser_activity.errors, status: :unprocessable_entity
    end
  end

  # DELETE /multiuser_activities/1
  def destroy
    @multiuser_activity.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_multiuser_activity
      @multiuser_activity = MultiuserActivity.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def multiuser_activity_params
      params.permit(:activity_id, :multiuser_id, :year)
    end
end
