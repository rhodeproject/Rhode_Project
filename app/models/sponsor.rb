class Sponsor < ActiveRecord::Base
  attr_accessible :club_id, :image_name, :name, :url, :description, :label, :priority, :facebook_id, :twitter_id
  belongs_to :club

  URL_REGEX = /^(http[s]?:\/\/)([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/

  validates :name, :presence => true
  validates :club_id, :presence => true
  validates :url, :presence => true,
            :format => {:with => URL_REGEX}

  def image_path
    #if the image_name starts with http then use the path entered else append /assets/
    path = self.image_name
    unless self.image_name.slice(0..3).downcase == "http"
      path = "/assets/#{self.image_name}"
    end
    path
  end
end
