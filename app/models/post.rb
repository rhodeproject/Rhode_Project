class Post < ActiveRecord::Base
  attr_accessible :content, :poster_id

  #Validation
  validates :content
  belongs_to :topic
end
