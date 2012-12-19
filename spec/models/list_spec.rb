require 'spec_helper'

describe List do
  before(:each) do
    @event = create(:event)
    @user = create(:user)

    @list = create(:list)
    #@list.update_attribute('state', "Signed Up")

  end
  it "should be valid with valid attributes" do
    @list.should be_valid
  end
  it "should valid with out state" do
    @list.state = nil
    @list.should be_valid
  end
end
