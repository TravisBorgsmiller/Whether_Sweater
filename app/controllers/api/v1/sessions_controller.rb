class Api::V1::SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      render json: {status: 200, body: UserSerializer.new(user)}
    else
      render json: {status: 400, body: "Email or Password Invalid"}
    end
  end
end
