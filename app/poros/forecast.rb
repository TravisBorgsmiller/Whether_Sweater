class Forecast
  attr_reader :id,
              :current_weather,
              :hourly_weather,
              :five_day_forecast,
              :time_and_date
  def initialize(data)
    @id = nil
    @current_weather = data[:current]
    @hourly_weather = data[:hourly][1..8]
    @five_day_forecast = data[:daily][1..8]
    @time_and_date = get_time_date(data[:current][:dt])
    # @location = GoogleService.get_location_info_for_weather
  end

  def get_time_date(time_date)
    t = Time.at(time_date).to_datetime
    t.strftime("%l:%M %p %B,%e")
  end

end
