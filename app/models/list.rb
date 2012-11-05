class List < ActiveRecord::Base
  attr_accessible :event_id, :state, :user_id

  belongs_to  :user
  belongs_to  :event
end
