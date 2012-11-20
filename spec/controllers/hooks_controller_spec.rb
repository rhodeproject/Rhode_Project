require 'spec_helper'

describe HooksController do

  describe 'post to receiver' do
    it "should return http OK" do
      post 'receiver'
      response.should be_success
    end
  end
end
