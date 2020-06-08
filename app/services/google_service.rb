class GoogleService
  def get_distance(starting, ending)
    response = conn.get("directions/json?&origin=#{starting}&destination=#{ending}")
    JSON.parse(response.body)
  end

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

end
