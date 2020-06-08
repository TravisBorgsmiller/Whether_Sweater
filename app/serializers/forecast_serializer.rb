class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :current_weather, :hourly_weather, :five_day_forecast, :time_and_date
end
