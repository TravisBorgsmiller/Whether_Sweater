class GoogleService
  def get_geocode(location)
    response = conn.get("geocode/json?address=#{location}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new('https://maps.googleapis.com/maps/api') do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.params['key'] = ENV['GOOGLE_API_KEY']
    end
  end

  # def self.get_location_info_for_weather(default = ForecastFacade.get_geocode)
  #   binding.pry
  # end

end
