class Post < ActiveRecord::Base
  # == Schema Information
  #
  # Table name: posts
  #
  #  id         :integer         not null, primary key
  #  content    :text
  #  created_at :datetime        not null
  #  updated_at :datetime        not null
  #  user_id    :integer
  #  topic_id   :integer
  #
  attr_accessible :content, :topic_id, :club_id

  validates :content, :presence => true

  belongs_to  :user
  belongs_to  :topic
  belongs_to  :club

  scope :responses, {:order => ["created_at DESC"]}

  def self.text_search(query)
    if query.present?
      where("content @@ :q", :q => "%#{query}%")
    else
      scoped
    end
  end

  def create_email_list(topic)
    #create an array of email addresses that want an email when forum is posted to
    topic_dl = []
    forum = topic.forum
    forum.users.each do |f|
      if f.active? #don't add users that are not active
        topic_dl.push(f)
      else
        forum.toggle_user(f,RhodeProject::FORUM_UNFOLLOW) #remove the user from following the forum if they are inactive
      end
    end

    #add to array of emails addresses not included in the above array
    #and have already responded to the topic
    topic.posts.each do |p|
      u = User.find(p.user_id)
      topic_dl.push(u) unless topic_dl.include?(u) if u.active?
    end

    topic_dl.each do |u|
      UserMailer.post_forum_notice(forum,u.email,self,u.club.sub_domain).deliver
      #UserMailer.delay.post_forum_notice(forum,u.email,self,u.club.sub_domain)
    end
  end

end


