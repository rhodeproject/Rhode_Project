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

  validates :name, presence: true, length:{maximum: 50}
  validates :sub_domain, uniqueness: {case_sensitive: false}

  before_save { |club| club.sub_domain = sub_domain.downcase}

  accepts_nested_attributes_for :users
end
