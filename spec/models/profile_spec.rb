require 'spec_helper'

describe Profile do
  before(:each) do
    @profile = Profile.new
  end

  it "should belong to a user" do
    @profile.update_attributes(:user_id => 1 )
    @profile.should be_valid
  end
end
