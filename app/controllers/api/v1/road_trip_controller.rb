class Api::V1::RoadTripController < ApplicationController

  def create
    if !params[:api_key]
      render json: error('no api key found'), status: 401
    elsif User.authenticate_token(params[:api_key])
      road_trip = RoadTrip.new(strong_params)
      render json: RoadTripSerializer.new(road_trip), status: 201
    else
      render json: error('Invalid api key'),
             status: 401
    end
  end

  private

  def strong_params
    params.permit(:origin, :destination)
  end

  def error(message)
                  {
                   detail: message,
                   title: 'Unauthorized Request',
                   parameter: 'api_key',
                   status: 401
                 }
  end
end
