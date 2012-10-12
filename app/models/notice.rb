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
    #@client = Twitter::Client.new(
    #    :consumer_key => "h1k7qWwK9hIDQj5dBBmPQ",
    #    :consumer_secret => "DYsQHucq6Xd3idw05WYa9RQ67xhmZeimkSGXEVBE",
    #    :oath_token => "550093262-vJ2eQiMBU6pxrFEBc0xPdE76smzgJTuA86Q64mH5",
    #    :oath_token_secret => "hd6nh519tivT5d3LCoM0lV48fVSODqVAvstF9o3ogE"
    #)
    Twitter.configure do |config|
      config.consumer_key = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret = ENV["TWITTER_CONSUMER_SECRET"]
      config.oauth_token = key
      config.oauth_token_secret = secret_key
    end
  end
end
