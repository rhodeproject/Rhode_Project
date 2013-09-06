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

  attr_accessible :description, :name, :admin
  has_many :topics, :dependent => :destroy
  has_and_belongs_to_many :users
  belongs_to :club

  validates :name, :presence => true

  def to_param
    "#{id} #{name}".parameterize
  end

  def most_recent_post
    topic = Topic.first(:order => 'last_post_at DESC', :conditions => ['forum_id = ?', self.id])
  end

  def email_followers(topic, post)
    self.users.each do |user|
      UserMailer.delay.post_forum_notice(topic.forum,user.email,post,user.club.sub_domain)
    end
  end

  def make_admin
    self.admin = true
    save!
  end

  def following?(user)
    self.users.where(:id => user.id).present?
  end

  def toggle_user(user,val)
    if self.users.where(:id => user.id).present? && val == RhodeProject::FORUM_UNFOLLOW
      self.users.delete(user)
    elsif val == RhodeProject::FORUM_FOLLOW
      self.users << user
    end
  end

end


