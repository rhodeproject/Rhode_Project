require 'spec_helper'

describe Event do
  before(:each) do
    @event = Event.new(:title => "Title", :starts_at => Date.today, :ends_at => Date.tomorrow)
  end

  it "it be valid with valid attributes" do
    @event.should be_valid
  end

  it "should not be valid with out a title" do
    @event.title = nil
    @event.should_not be_valid
  end

  it "should not be valid with out a starts_at date" do
    @event.starts_at = nil
    @event.should_not be_valid
  end

  it "should not be valid with out an ends_at date" do
    @event.ends_at = nil
    @event.should_not be_valid
  end


  it "should not be valid with invalid datetime for starts_at" do
    @event.starts_at = "111111111"
    @event.should_not be_valid
  end

  it "should not be valid with invalid datetime for ends_at" do
    @event.ends_at = "111111111"
    @event.should_not be_valid
  end

end
