class Api::V1::FoodieController < ApplicationController

  def show
    google_service = GoogleService.new.get_distance(params[:start], params[:end])
    entity_info = Faraday.new('https://developers.zomato.com/api/v2.1/geocode?') do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.headers['user-key'] = ENV['ZOMATO_API_KEY']
      faraday.params['lat'] = google_service['routes'][0]['legs'][0]['end_location']['lat']
      faraday.params['lon'] = google_service['routes'][0]['legs'][0]['end_location']['lng']
    end
    binding.pry
  end

end
