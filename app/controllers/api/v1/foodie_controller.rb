class Api::V1::FoodieController < ApplicationController

  def show
    google_service = GoogleService.new.get_distance(params[:start], params[:end])
    response = Faraday.get('https://developers.zomato.com/api/v2.1/geocode?') do |faraday|
      faraday.headers['user-key'] = ENV['ZOMATO_API_KEY']
      faraday.params['lat'] = google_service['routes'][0]['legs'][0]['end_location']['lat']
      faraday.params['lon'] = google_service['routes'][0]['legs'][0]['end_location']['lng']
    end
    entity_info = JSON.parse(response.body, symbolize_names: true)
    restaurant_info = Faraday.get("https://developers.zomato.com/api/v2.1/search?entity_id=#{entity_info[:location][:entity_id]}&entity_type=subzone&cuisines=#{entity_info[:location][:entity_type]}") do |faraday|
      faraday.headers['user-key'] = ENV['ZOMATO_API_KEY']
    end
    binding.pry
  end

end
