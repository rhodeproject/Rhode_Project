class Club < ActiveRecord::Base
# == Schema Information
#
# Table name: clubs
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  sub_domain      :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  welcome_message :text
#  heading1        :string(255)
#  heading2        :string(255)
#  heading3        :string(255)
#  message1        :text
#  message2        :text
#  message3        :text
#
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
  has_one  :token

  validates :name, presence: true, length:{maximum: 50}
  validates :sub_domain, uniqueness: {case_sensitive: false}

  before_save { |club| club.sub_domain = sub_domain.downcase}

  accepts_nested_attributes_for :users
end


