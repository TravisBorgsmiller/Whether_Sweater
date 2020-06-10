require 'rails_helper'

RSpec.describe 'As a user', type: :request do
  it 'returns user info when proper login is sent' do
    user = User.create!(email: "hotones@example.com",
        password: "password",
        password_confirmation: "password")

    post '/api/v1/sessions', params: {email: "hotones@example.com", password: "password"}

    user = JSON.parse(response.body, symbolize_names: true)[:body]
    expect(user[:data][:attributes]).to have_key(:email)
    expect(user[:data][:attributes]).to have_key(:api_key)
  end

  it 'returns 404 error if invalid info is passed in' do
    user = User.create!(email: "hotones@example.com",
        password: "password",
        password_confirmation: "password")

    post '/api/v1/sessions', params: {email: "hotones@example.com", password: "password1"}
    error = JSON.parse(response.body, symbolize_names: true)

    expect(error[:status]).to eq(400)
    expect(error[:body]).to eq("Email or Password Invalid")
  end

end
