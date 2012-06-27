class Micropost < ActiveRecord::Base
  # == Schema Information
  #
  # Table name: microposts
  #
  #  id         :integer         not null, primary key
  #  content    :string(255)
  #  user_id    :integer
  #  created_at :datetime        not null
  #  updated_at :datetime        not null
  #
  attr_accessible :content

  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 140}
  belongs_to :user


  def self.from_users_followed_by(user)
    followed_user_ids = user.followed_user_ids.join(', ')
    where("user_id IN (?) OR user_id = ?", followed_user_ids, user)
  end

  #scopes
  default_scope order: 'microposts.created_at DESC'

  # Returns microposts from the users being followed by the given user.
  scope :from_users_followed_by, lambda { |user| followed_by(user) }

  #private functions
  # Returns an SQL condition for users followed by the given user.
  # We include the user's own id as well.
  def self.followed_by(user)
    followed_user_ids = %(SELECT followed_id FROM relationships
                            WHERE follower_id = :user_id)
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
          { user_id: user })
  end
end


