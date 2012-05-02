class Post < ActiveRecord::Base
  attr_accessible :content, :topic_id

  belongs_to  :user
  belongs_to  :topic

end
