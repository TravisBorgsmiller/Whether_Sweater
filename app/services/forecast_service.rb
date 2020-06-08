class ForecastService

  def get_forecast_data(coordinates)
    response = conn.get("onecall?") do |req|
      req.params['lat'] = coordinates[:lat]
      req.params['lon'] = coordinates[:lng]
      req.params['units'] = 'imperial'
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new('https://api.openweathermap.org/data/2.5') do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.params['appid'] = ENV['OPEN_WEATHER_KEY']
    end
  end

end
