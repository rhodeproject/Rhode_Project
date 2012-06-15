class Club < ActiveRecord::Base
  attr_accessible :name,
                  :sub_domain,
                  :heading1,
                  :heading2,
                  :heading3,
                  :message1,
                  :message2,
                  :message3
  has_many :users
  has_many :forums
  has_many :events

  accepts_nested_attributes_for :users
end
