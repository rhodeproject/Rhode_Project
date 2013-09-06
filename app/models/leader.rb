class Leader < ActiveRecord::Base
  attr_accessible :club_id, :title, :user_id, :rank

  belongs_to :user
  belongs_to :club


end
