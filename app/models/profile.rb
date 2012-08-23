class Profile < ActiveRecord::Base
  attr_accessible :age, :bio, :blog, :user_id

end
