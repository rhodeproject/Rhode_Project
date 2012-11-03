class Sponsor < ActiveRecord::Base
  attr_accessible :club_id, :image_name, :name, :url, :description
  belongs_to :club

  URL_REGEX = /^(http[s]?:\/\/)([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/

  validates :name, presence: true
  validates :club_id, presence: true
  validates :url, presence: true,
            format: {with: URL_REGEX}
end
