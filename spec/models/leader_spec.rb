require 'spec_helper'

describe Leader do
  before(:each) do
    @leader = Leader.new
  end

  it "should be valid with a string title" do
    @leader.should be_valid
  end

end
