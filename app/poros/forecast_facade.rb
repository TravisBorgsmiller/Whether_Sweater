class ForecastFacade
  def initialize(location)
    @location = location
  end

  def get_geocode
    geocode_service = GoogleService.new
    response = geocode_service.get_geocode(@location)
    coordinates = response[:results][0][:geometry][:location]
  end

  def get_forecast
    forecast_service = ForecastService.new
    response = forecast_service.get_forecast_data(get_geocode)
  end

end
