class Api::V1::UsersController < ApplicationController

  def create
    user = User.create(user_params)
    if user.save
      render json: {status: 201, body: UserSerializer.new(user)}
    else
      render json: {status: 400, body: user.errors.full_messages.to_sentence}
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

end
