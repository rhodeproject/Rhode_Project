class Forum < ActiveRecord::Base
  # == Schema Information
  #
  # Table name: forums
  #
  #  id          :integer         not null, primary key
  #  name        :string(255)
  #  description :string(255)
  #  created_at  :datetime        not null
  #  updated_at  :datetime        not null
  #  club_id     :integer
  #

  attr_accessible :description, :name
  has_many :topics, dependent: :destroy
  has_and_belongs_to_many :users
  belongs_to :club

  validates :name, presence: true

  def most_recent_post
    topic = Topic.first(:order => 'last_post_at DESC', :conditions => ['forum_id = ?', self.id])
  end
end


