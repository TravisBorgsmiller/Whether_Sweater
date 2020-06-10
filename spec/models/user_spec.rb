require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'methods' do
    describe 'authenticate_token' do
      it 'returns true if api_key found for user' do
        user = User.create!(email: "hotones@example.com",
            password: "password",
            password_confirmation: "password")
        expect(User.authenticate_token(user.api_key)).to eq(true)
        expect(User.authenticate_token('jfalkafljkafklkfajkls')).to eq(false)
      end
    end
  end
end
