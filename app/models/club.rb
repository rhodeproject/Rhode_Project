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
                  :message3,
                  :about,
                  :contact_email,
                  :oath_token,
                  :oath_token_secret,
                  :fee,
                  :stripe_api_key,
                  :stripe_publishable_key
  has_many :users
  has_many :forums
  has_many :events
  has_many :notices
  has_one  :token
  has_many :sponsors
  belongs_to :subscription

  validates :name, presence: true, length:{maximum: 50}
  validates :sub_domain, uniqueness: {case_sensitive: false}

  before_save { |club| club.sub_domain = sub_domain.downcase}

  accepts_nested_attributes_for :users
  accepts_nested_attributes_for :subscription

  def has_sponsors?
    self.sponsors.count > 0
  end

  def send_contact_email(content,sender_email,sender_name)
    UserMailer.delay.contact_email(content,sender_email,sender_name,self.contact_email)
  end
end


