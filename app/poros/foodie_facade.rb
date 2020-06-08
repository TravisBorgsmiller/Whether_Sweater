class FoodieFacade

  def initialize(start, ending, cuisine)
    @google_service = GoogleService.new.get_distance(start, ending)
    @start = start
    @ending = ending
    @cuisine = cuisine
    @entity_id = get_entity[:location][:entity_id]
    @restaurant_info = get_restaurant
    @forecast = get_foodie_forecast
    @travel_time = get_travel_time
  end

  def get_entity
    entity_response = Faraday.get('https://developers.zomato.com/api/v2.1/geocode?') do |faraday|
      faraday.headers['user-key'] = ENV['ZOMATO_API_KEY']
      faraday.params['lat'] = @google_service['routes'][0]['legs'][0]['end_location']['lat']
      faraday.params['lon'] = @google_service['routes'][0]['legs'][0]['end_location']['lng']
    end
    JSON.parse(entity_response.body, symbolize_names: true)
  end

  def get_restaurant
    restaurant_response = Faraday.get("https://developers.zomato.com/api/v2.1/search?entity_id=#{@entity_id}&entity_type=subzone&q=#{@cuisine}") do |faraday|
      faraday.headers['user-key'] = ENV['ZOMATO_API_KEY']
    end
    parsed_restaurant_info = JSON.parse(restaurant_response.body, symbolize_names: true)
    parsed_restaurant_info[:restaurants][0]
  end

  def get_travel_time
    @google_service['routes'][0]['legs'][0]['duration']['text']
  end

  def get_foodie_forecast
    forecast_service = ForecastService.new.get_forecast_data(@google_service['routes'][0]['legs'][0]['end_location'].symbolize_keys)
    forecast_service[:current]
  end

  def create_foodie_object
    Foodie.new(@ending, @travel_time, get_foodie_forecast, get_restaurant)
  end
end
