class Club < ActiveRecord::Base
  attr_accessible :name, :sub_domain
  has_many :users
  has_many :forums
  has_many :events

  accepts_nested_attributes_for :users
end
