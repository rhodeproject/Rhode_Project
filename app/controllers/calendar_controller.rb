class CalendarController < ApplicationController
  before_filter :signed_in_user
  def index
    @event = Event.new
  end
  
end
