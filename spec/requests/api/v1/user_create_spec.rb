require 'rails_helper'

RSpec.describe 'As a user going to post endpoint', type: :request do
  it 'can create a new user' do
    user_params = {email: "hotones@pete.com", password: "spicy", password_confirmation: "spicy"}
    
    post '/api/v1/users', params: user_params

    expect(response).to be_successful
    user = JSON.parse(response.body, symbolize_names: true)[:body]
    expect(user[:data][:attributes]).to have_key(:email)
    expect(user[:data][:attributes]).to have_key(:api_key)
  end

  it 'should return 400 error if not correct information is sent' do
    user_params = {email: "hotones@pete.com", password: "spicy", password_confirmation: "spicy1"}

    post '/api/v1/users', params: user_params

    error = JSON.parse(response.body, symbolize_names: true)
    expect(error[:status]).to eq(400)
    expect(error[:body]).to eq("Password confirmation doesn't match Password")
  end

end
