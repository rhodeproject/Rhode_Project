class Topic < ActiveRecord::Base
  # == Schema Information
  #
  # Table name: topics
  #
  #  id             :integer         not null, primary key
  #  name           :string(255)
  #  last_poster_id :integer
  #  last_post_at   :datetime
  #  created_at     :datetime        not null
  #  updated_at     :datetime        not null
  #  forum_id       :integer
  #  user_id        :integer
  #
  attr_accessible :last_post_at, :last_poster_id, :name

  validates :name, :presence => true

  belongs_to :forum
  belongs_to  :user
  has_many :posts, :dependent => :destroy

  def to_param
    "#{id} #{name}".parameterize
  end

  def responses
    offset = self.posts.count - 1
    self.posts.last(offset).reverse
  end

end


