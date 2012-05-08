class Forum < ActiveRecord::Base
  attr_accessible :description, :name
  has_many :topics, dependent: :destroy
  has_and_belongs_to_many :users

  def most_recent_post
    topic = Topic.first(:order => 'last_post_at DESC', :conditions => ['forum_id = ?', self.id])

  end
end
