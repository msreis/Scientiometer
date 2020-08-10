# frozen_string_literal: true

class AuthenticationController < ApplicationController
  before_action :authorize_request, except: :login

  # POST /auth/login

  def login
    @account = Account.find_by_username(params[:username])

    if @account&.authenticate(params[:password])
      employee = Employee.find(@account[:employee_id]) if @account.employee_id
      access_level = Profile.find(@account[:profile_id]).access_level
      token = JsonWebToken.encode(account_id: @account.id)
      time = Time.now + 1.day.to_i
      account_id = @account.id

      render json: { token: token,
                     exp: time.strftime('%Y-%m-%dT%H:%M'),
                     username: @account.username,
                     laboratory: employee&.laboratory_id,
                     permission: access_level,
                     id: account_id },
             status: :ok
    else
      render json: { error: 'não autorizado' }, status: :unauthorized
    end
  end

  private

  def login_params
    params.permit(:username, :password)
  end
end
