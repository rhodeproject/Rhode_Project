require 'spec_helper'

describe Event do
  before(:each) do
    @event = Event.new
    @today = Date.today
    @invalid_date = '123123123'
    @title = "Test Title"
    @tomorrow = Date.tomorrow
  end

  it "it be valid with valid attributes" do
    @event.update_attributes(:title => @title, :starts_at => @today, :ends_at => @tomorrow)
    @event.should be_valid
  end

  it "should not be valid with out a title" do
    @event.update_attributes(:starts_at => @today, :ends_at => @tomorrow)
    @event.should_not be_valid
  end

  it "should not be valid with out a starts_at date" do
    @event.update_attributes(:title => @title, :ends_at => @tomorrow)
    @event.should_not be_valid
  end

  it "should not be valid with out an ends_at date" do
    @event.update_attributes(:title => @title, :starts_at => @today)
    @event.should_not be_valid
  end


  it "should not be valid with invalid datetime for starts_at" do
    @event.update_attributes(:title => @title, :starts_at => @invalid_date, :ends_at => @tomorrow)
    @event.should_not be_valid
  end

  it "should not be valid with invalid datetime for ends_at" do
    @event.update_attributes(:title => @title, :starts_at => @today, :ends_at => @invalid_date)
    @event.should_not be_valid
  end

end
