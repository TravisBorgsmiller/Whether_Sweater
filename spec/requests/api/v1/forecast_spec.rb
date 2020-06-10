require 'rails_helper'

RSpec.describe 'As a user' do
  describe 'can get forecast data' do
    it 'can get forecast based on location' do

      get "/api/v1/forecast?location=denver,co"
      expect(response).to be_successful
      json_response = JSON.parse(response.body)
      expect(json_response['data']['attributes']).to have_key("current_weather")
      expect(json_response['data']['attributes']).to have_key("hourly_weather")
      expect(json_response['data']['attributes']).to have_key("five_day_forecast")
      expect(json_response['data']['attributes']).to have_key("time_and_date")
      expect(json_response['data']['attributes']).to have_key("location")
    end
  end
end
