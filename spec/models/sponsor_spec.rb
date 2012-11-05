require 'spec_helper'

describe Sponsor do
  before(:each) do
    @sponsor = Sponsor.new(:name => "test sponsor", :url => "https://www.test.com", :club_id => 1)
  end

  it "should be valid with valid attributes" do
    @sponsor.should be_valid
  end

  it "should not be valid without leading http" do
    @sponsor.url =  "www.afford.com"
    @sponsor.should_not be_valid
  end
end
