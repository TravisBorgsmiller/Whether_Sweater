require 'rails_helper'

RSpec.describe 'As a user' do
  describe 'can get foodie data' do
    it 'can get foodie info based on location' do

    get "/api/v1/foodie?start=denver,co&end=pueblo,co&search=italian"
    expect(response).to be_successful
    json_response = JSON.parse(response.body)
    expect(json_response['data']['attributes']).to have_key("end_location")
    expect(json_response['data']['attributes']).to have_key("travel_time")
    expect(json_response['data']['attributes']).to have_key("forecast")
    expect(json_response['data']['attributes']).to have_key("restaurant")
    end
  end
end
