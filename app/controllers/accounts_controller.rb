# frozen_string_literal: true

class AccountsController < ApplicationController
  before_action :set_account, only: %i[show update destroy]
  before_action :authorize_request, except: :create

  # GET /accounts
  def index
    if @current_access_level == 4
      @accounts = Account.all.references(:employee)

    elsif @current_access_level == 3
      curr_employee = Employee.find(@curr_employee.employee_id)
      curr_lab = Laboratory.find(curr_employee[:laboratory_id])
      # Find all accounts from same laboratory divisino
      @accounts = Account.where(employee_id: Employee.where(laboratory_id: Laboratory.where(laboratory_division_id: curr_lab[:laboratory_dvision_id])))

    elsif @current_access_level == 2
      curr_employee = Employee.find(@current_account.employee_id)
      # Find all accounts from same laboratory
      @accounts = Account.where(employee_id: Employee.where(laboratory_id: curr_employee[:laboratory_id])).references(:employee)

    else
      curr_employee = Employee.find(@current_account.employee_id)
      @accounts = Account.where(employee_id: curr_employee).references(:employee)

    end

    @accounts = Account.all

    render json: @accounts
  end

  # GET /accounts/1
  def show
    render json: @account
  end

  # POST /accounts
  def create
    @account = Account.new(account_params)

    if @account.save
      render json: @account, status: :created, location: @account
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /accounts/1
  def update
    
    if @account.authenticate(params[:current_password]) && @account.update(account_params)
      render json: @account
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  # DELETE /accounts/1
  def destroy
    @account.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_account
    @account = Account.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def account_params
    params.permit(:username, :password, :profile_id)
  end
end
