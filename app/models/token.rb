class Token < ActiveRecord::Base
  before_create :generate_access_token
  belongs_to :club

  private

    def generate_access_token
      begin
        self.api_token = SecureRandom.hex
      end while self.class.exists?(api_token: api_token)
    end
end
