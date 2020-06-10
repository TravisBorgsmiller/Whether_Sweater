require 'rails_helper'

RSpec.describe 'As a user' do
  describe 'when sending correct info to road trip endpoint' do
    it 'returns relevant info' do
      user = User.create!(email: "hotones@example.com",
          password: "password",
          password_confirmation: "password")

      post "/api/v1/road_trip", params: {origin: "Denver,CO", destination: "Pueblo,CO", api_key: user.api_key}
      expect(response.status).to eq(201)
      json_response = JSON.parse(response.body)
      expect(json_response["data"]["attributes"]).to have_key("origin")
      expect(json_response["data"]["attributes"]).to have_key("destination")
      expect(json_response["data"]["attributes"]).to have_key("travel_time")
      expect(json_response["data"]["attributes"]).to have_key("forecast")
    end

  end
  describe 'when sending invalid or no api key' do
    it 'returns relevant info for invalid' do
      user = User.create!(email: "hotones@example.com",
          password: "password",
          password_confirmation: "password")

      post "/api/v1/road_trip", params: {origin: "Denver,CO", destination: "Pueblo,CO", api_key: "fsjklasfjkljakfsfjak"}
      expect(response.status).to eq(401)
      json_response = JSON.parse(response.body)
      expect(json_response).to have_key("detail")
      expect(json_response).to have_key("title")
      expect(json_response).to have_key("parameter")
    end

    it 'returns relevant info for no api key' do
      user = User.create!(email: "hotones@example.com",
          password: "password",
          password_confirmation: "password")

      post "/api/v1/road_trip", params: {origin: "Denver,CO", destination: "Pueblo,CO"}
      expect(response.status).to eq(401)
      json_response = JSON.parse(response.body)
      expect(json_response).to have_key("detail")
      expect(json_response).to have_key("title")
      expect(json_response).to have_key("parameter")
    end

  end

end
