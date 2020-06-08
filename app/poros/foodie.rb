class Foodie
  attr_reader :id, :end_location, :travel_time, :forecast, :restaurant

  def initialize(end_location, travel_time, forecast, restaurant)
    @end_location = end_location
    @travel_time = travel_time
    @forecast = make_forecast(forecast)
    @restaurant = make_restaurant(restaurant)
  end

  def make_forecast(forecast_info)
    forecast = {}
    forecast[:summary] = forecast_info[:weather][0][:description]
    forecast[:temperature] = forecast_info[:temp]
    forecast
  end

  def make_restaurant(restaurant_info)
    restaurant = {}
    restaurant[:name] = restaurant_info[:restaurant][:name]
    restaurant[:address] = restaurant_info[:restaurant][:location][:address]
    restaurant
  end

end
