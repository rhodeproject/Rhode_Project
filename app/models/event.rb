class Event < ActiveRecord::Base
  attr_accessible :name, :start_at, :end_at
  belongs_to :club

  has_event_calendar
end
