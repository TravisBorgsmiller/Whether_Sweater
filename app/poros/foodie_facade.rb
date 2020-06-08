class FoodieFacade

  def initialize(start, ending, cuisine)
    @start = start
    @ending = ending
    @cuisine = cuisine
    @entity_id = get_entity[:location][:entity_id]
    @restaurant_info = get_restaurant
  end

  def get_entity
    google_service = GoogleService.new.get_distance(@start, @ending)
    entity_response = Faraday.get('https://developers.zomato.com/api/v2.1/geocode?') do |faraday|
      faraday.headers['user-key'] = ENV['ZOMATO_API_KEY']
      faraday.params['lat'] = google_service['routes'][0]['legs'][0]['end_location']['lat']
      faraday.params['lon'] = google_service['routes'][0]['legs'][0]['end_location']['lng']
    end
    JSON.parse(entity_response.body, symbolize_names: true)
  end
  def get_restaurant
    restaurant_response = Faraday.get("https://developers.zomato.com/api/v2.1/search?entity_id=#{@entity_id}&entity_type=subzone&q=#{@cuisine}") do |faraday|
      faraday.headers['user-key'] = ENV['ZOMATO_API_KEY']
    end
    restaurant_info = JSON.parse(restaurant_response.body, symbolize_names: true)
    restaurant_name = restaurant_info[:restaurants][0][:restaurant][:name]
    binding.pry
  end

end
