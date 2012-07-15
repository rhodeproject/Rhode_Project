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
  attr_accessible :content, :topic_id

  validates :content, presence: true

  belongs_to  :user
  belongs_to  :topic

  def self.text_search(query)
    if query.present?
      where("content @@ :q", q: "%#{query}%")
    else
      scoped
    end
  end

end


