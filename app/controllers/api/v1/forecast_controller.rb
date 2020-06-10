class Api::V1::ForecastController < ApplicationController

  def show
    forecast_search = ForecastFacade.new(params[:location])
    forecast = Forecast.new(forecast_search.get_forecast, params[:location])
    render json: ForecastSerializer.new(forecast)
  end

end
