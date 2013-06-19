class User < ActiveRecord::Base
  validates :username, :oauth_token, :oauth_secret, presence: true

  has_many :tweets

  def tweet(status)
    tweet = tweets.create!(:text => status)
    TweetWorker.perform_in(1.minute.from_now, tweet.id)
  end
end
