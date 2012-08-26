class Notice < ActiveRecord::Base
  attr_accessible :content

  belongs_to :club
  validates :content, presence: true
end
