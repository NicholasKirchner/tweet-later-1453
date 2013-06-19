class User < ActiveRecord::Base
  validates :username, :oauth_token, :oauth_secret, presence: true
end
