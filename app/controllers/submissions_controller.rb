# frozen_string_literal: true

class SubmissionsController < ApplicationController
  before_action :set_submission, only: %i[show update destroy]
  before_action :authorize_request, only: %i[accept my_submissions reprove submit]

  # GET /submissions
  def index
    @submissions = Submission.all

    render json: @submissions
  end

  # GET /submissions/1
  def show
    render json: @submission
  end

  def my_submissions
    @submissions = Submission.where(account_id: @current_account.id)

    ret = []
    @submissions.each do |sub|
      obj = {}
      obj[:accepted] = sub[:accepted]
      obj[:submitted] = sub[:submitted]
      obj[:reproved] = sub[:reproved]
      obj[:last] = sub[:last_modified]
      obj[:id] = sub[:id]

      acc = Account.find(sub[:account_id])
      emp = Employee.find(acc[:employee_id])
      obj[:name] = emp[:name]
      ret << obj
    end

    render json: ret
  end

  def submissions_by_lab(lab_id)
    emps = Employee.where(laboratory_id: lab_id).map { |emp| emp[:id] }
    accs = Account.where(employee_id: emps)
    accs.map { |acc| acc[:id] }

    Submission.where(account_id: accs)
  end

  def submissions
    @submissions = if params[:laboratory]
                     submissions_by_lab(params[:laboratory])
                   else
                     Submission.all
                   end

    ret = []
    @submissions.each do |sub|
      obj = {}
      obj[:accepted] = sub[:accepted]
      obj[:submitted] = sub[:submitted]
      obj[:reproved] = sub[:reproved]
      obj[:last] = sub[:last_modified]
      obj[:id] = sub[:id]

      acc = Account.find(sub[:account_id])
      emp = Employee.find(acc[:employee_id])
      obj[:name] = emp[:name]
      ret << obj
    end

    render json: ret
  end

  # Summary by laboratory division
  def summary
    labs = Laboratory.all
    ret = []
    labs.each do |lab|
      subs = submissions_by_lab(lab[:id])
      n_accepted = 0
      subs.each do |sub|
        n_accepted += 1 if sub.accepted
      end
      ret << { id: lab[:id],
               name: lab[:name],
               partial: n_accepted,
               all: subs.size }
    end
    render json: ret, status: :ok
  end

  def accept
    return if @current_access_level < 2

    ActiveRecord::Base.transaction do
      sub = Submission.find(params[:id])
      sub.accepted = true
      sub.reproved = false
      sub.submitted = false
      sub.save!

      create_approval_history(params[:account], params[:approval_action], params[:id], params[:comment])
    end

    render nothing: true, status: :ok
  end

  def reprove
    return if @current_access_level < 2

    puts params

    ActiveRecord::Base.transaction do
      sub = Submission.find(params[:id])
      sub.reproved = true
      sub.accepted = false
      sub.submitted = false
      sub.save!

      create_approval_history(params[:account], params[:approval_action], params[:id], params[:comment])
    end

    render nothing: true, status: :ok
  end

  def submit

    puts params

    ActiveRecord::Base.transaction do
      sub = Submission.find(params[:id])
      sub.submitted = true
      sub.reproved = false
      sub.accepted = false
      sub.save!

      create_approval_history(params[:account], params[:approval_action], params[:id], params[:comment])
    end

    render nothing: true, status: :ok
  end

  # POST /submissions
  def create
    @submission = Submission.new(submission_params)

    if @submission.save
      render json: @submission, status: :created, location: @submission
    else
      render json: @submission.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /submissions/1
  def update
    if @submission.update(submission_params)
      render json: @submission
    else
      render json: @submission.errors, status: :unprocessable_entity
    end
  end

  # DELETE /submissions/1
  def destroy
    @submission.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_submission
    @submission = Submission.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def submission_params
    params.require(:submission).permit(:accepted)
  end

  def create_approval_history(account_id, approval_action_name, submission_id, comment)
    account = Account.find(account_id)
    approval_action = ApprovalAction.find_by(name: approval_action_name)

    ApprovalHistory.create(
        submission_id: submission_id,
        account_id: account.id,
        approval_action_id: approval_action.id,
        comment: comment
    ).save!
  end
end
