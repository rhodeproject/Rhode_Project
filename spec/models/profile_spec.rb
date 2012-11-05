require 'spec_helper'

describe Profile do
  before(:each) do
    @profile = Profile.new(:user_id => 1 )
  end

  it "should belong to a user" do
    @profile.should be_valid
  end
end
