class FoodieFacade

  google_service = GoogleService.new.get_distance(params[:start], params[:end])
  entity_response = Faraday.get('https://developers.zomato.com/api/v2.1/geocode?') do |faraday|
    faraday.headers['user-key'] = ENV['ZOMATO_API_KEY']
    faraday.params['lat'] = google_service['routes'][0]['legs'][0]['end_location']['lat']
    faraday.params['lon'] = google_service['routes'][0]['legs'][0]['end_location']['lng']
  end
  entity_info = JSON.parse(entity_response.body, symbolize_names: true)
  restaurant_response = Faraday.get("https://developers.zomato.com/api/v2.1/search?entity_id=#{entity_info[:location][:entity_id]}&entity_type=subzone&q=#{params[:search]}") do |faraday|
    faraday.headers['user-key'] = ENV['ZOMATO_API_KEY']
  end
  restaurant_info = JSON.parse(restaurant_response.body, symbolize_names: true)
  restaurant_name = restaurant_info[:restaurants][0][:restaurant][:name]
  binding.pry
  restaurant_address =

end
