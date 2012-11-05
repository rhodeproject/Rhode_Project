require 'spec_helper'

describe List do
  before(:each) do
    @event = Event.new(:title => "Title", :starts_at => Date.today, :ends_at => Date.tomorrow)
    @user = User.new(:name => "foo", :email => "foo@bar.com",
                     :password => "foobar",
                     :password_confirmation => "foobar")
    @event.users << @user
    @list = @event.lists.find_by_event_id(@user.id)
    @list.update_attribute('state', "Signed Up")

  end
  it "should be valid with valid attributes" do
    @list.should be_valid
  end
  it "should not be valid with out state" do
    @list.state = nil
    @list.should_not be_valid
  end
end
