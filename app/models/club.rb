class Club < ActiveRecord::Base
  attr_accessible :name, :sub_domain
  has_many :users

  accepts_nested_attributes_for :users
end
