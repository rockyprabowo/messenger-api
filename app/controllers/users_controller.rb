# frozen_string_literal: true

class UsersController < ApplicationController
  def register
    new_user = create_from_params
    token = authenticate(new_user.email, params[:password])
    json_response({ email: new_user.email, token: token })
  end

  def login
    token = authenticate(params[:email], params[:password])
    json_response({ token: token })
  end

  private

  def authenticate(email, password)
    AuthenticateUser.new(email, password).call
  end

  def create_from_params
    User.create(
      email: params[:email],
      password: params[:password],
      photo_url: params[:photo_url]
    )
  end
end
