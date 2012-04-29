class Post < ActiveRecord::Base
  attr_accessible :content, :poster_id
  belongs_to :topic
end
