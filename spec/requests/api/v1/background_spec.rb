require 'rails_helper'

RSpec.describe 'As a user' do
  describe 'based on my city and state' do
    it 'can return background image' do

      get "/api/v1/backgrounds?location=denver,co"

      expect(response).to be_successful
      json_response = JSON.parse(response.body)
      expect(json_response['data']['attributes']).to have_key("image_url")
    end

  end
end
