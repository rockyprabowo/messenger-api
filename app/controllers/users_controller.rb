# frozen_string_literal: true

class UsersController < ApplicationController
  include Authorization
  before_action :authorize, only: :current_user

  def register
    create_from_params
    authenticate(@new_user.email, params[:password])
    json_response({ user: @new_user, token: @token })
  end

  def login
    authenticate_from_params
    json_response({ token: @token })
  end

  def current_user
    json_response Current.user.include_email
  end

  private

  def register_params
    params.require(%i[name email password]).permit(:photo_url)
  end

  def authenticate(email, password)
    @token = AuthenticateUser.new(email, password).call
  end

  def authenticate_from_params
    authenticate(params[:email], params[:password])
  end

  def create_from_params
    @new_user = User.create!(register_params)
  end
end
