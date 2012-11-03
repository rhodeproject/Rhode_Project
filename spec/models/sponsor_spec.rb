require 'spec_helper'

describe Sponsor do
  before(:each) do
    @sponsor = Sponsor.new
    @name = "test sponsor"
    @url = "https://www.test.com"
    @club_id = "1"
  end

  it "should be valid with valid attributes" do
    @sponsor.update_attributes(:name => @name, :url => @url, :club_id => @club_id)
    @sponsor.should be_valid
  end

  it "should not be valid without leading http" do
    @sponsor.update_attributes(:name => @name, :url => "www.afford.com", :club_id => @club_id)
    @sponsor.should_not be_valid
  end
end
