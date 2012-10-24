class Notice < ActiveRecord::Base
  attr_accessible :content

  belongs_to :club
  validates :content, presence: true


  def send_tweet(club)
    #set_tokens
      Thread.new{
        set_tokens(club.oath_token, club.oath_token_secret)
        Twitter.update(self.content)
      }
  end

  def set_tokens(key, secret_key)
    Twitter.configure do |config|
      config.consumer_key = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret = ENV["TWITTER_CONSUMER_SECRET"]
      config.oauth_token = key
      config.oauth_token_secret = secret_key
    end
  end
end
