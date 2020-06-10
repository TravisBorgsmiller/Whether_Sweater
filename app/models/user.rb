class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  has_secure_token :api_key
  validates :api_key, uniqueness: true, presence: false
  has_secure_password

  validates_presence_of :password_digest

  def self.authenticate_token(token)
    where(api_key: token).any?
  end
end
