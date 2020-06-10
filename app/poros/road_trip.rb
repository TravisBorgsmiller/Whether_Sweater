class RoadTrip
  attr_reader :id, :forecast, :travel_time, :origin, :destination

  def initialize(params)
    @id = nil

    @start = params[:origin]
    @end = params[:destination]

    @forecast = generate_forecast
    @travel_time = distance_info
    @origin = city_state(@start)
    @destination = city_state(@end)
  end

  private

  def city_state(string)
    string.gsub(',', ', ')
  end

  def end_location_coordinates
    @end_location_info ||= GoogleService.new.get_geocode(@end)
  end

  def distance_info
    @distance_info ||= GoogleService.new.get_distance(@start, @end)
    @distance_info['routes'][0]['legs'][0]['duration']['text']
  end

  def generate_forecast
    response = ForecastService.new.get_forecast_data(end_location_coordinates[:results][0][:geometry][:location])
    {
      temp: response[:current][:temp],
      summary: response[:current][:weather][0][:description]
    }
  end
end
