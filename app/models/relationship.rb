class Relationship < ActiveRecord::Base
  # == Schema Information
  #
  # Table name: relationships
  #
  #  id          :integer         not null, primary key
  #  follower_id :integer
  #  followed_id :integer
  #  created_at  :datetime        not null
  #  updated_at  :datetime        not null
  #
  attr_accessible :followed_id

  #data relationships
  belongs_to :follower, :class_name => "User"
  belongs_to :followed, :class_name => "User"

  #validation
  validates :follower_id, :presence => true
  validates :followed_id, :presence => true

end


