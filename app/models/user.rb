# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  name                   :string(255)
#  email                  :string(255)
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#  password_digest        :string(255)
#  remember_token         :string(255)
#  admin                  :boolean         default(FALSE)
#  forum                  :boolean         default(FALSE)
#  reset_token            :string(255)
#  password_reset_sent_at :datetime
#  club_id                :integer
#

class User < ActiveRecord::Base
  require 'json'
  attr_accessible :email, :name, :password, :password_confirmation, :club_id
  has_secure_password

  #Data Relationships
  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through:  :relationships, source: :followed
  has_many :posts
  has_many :topics
  belongs_to :club
  has_and_belongs_to_many :forums
  has_one :profile

  #reverse relationship
  has_many :reverse_relationships, foreign_key: "followed_id",
           class_name:  "Relationship",
           dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  before_save :create_remember_token

  #convert email to Lowercase to ensure uniqueness in the DB
  before_save { |user| user.email = email.downcase}

  #create expiry date
  after_create :update_expiry

  #user validation
  validates :name, presence: true, length:{maximum: 50}

  #email validation
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}

  #TODO: drop index on user and email then impliment the following validation
  #validates_uniqueness_of :email, :scope => :club_id
  #password validation
  validates :password, length: {minimum: 6}

  #password_confirmation validation
  validates :password_confirmation, presence: true

  #scopes
  scope :admin, where(admin: true)

  #methods

  def active?
    self.active
  end

  def send_password_reset
    self.update_attribute('reset_token', generate_token)
    self.update_attribute('password_reset_sent_at', Time.zone.now)
    UserMailer.password_reset(self).deliver
  end

  def pay_membership_fee(token)
    charge = Stripe::Charge.create(
        :amount => self.club.fee * 100, # amount in cents, again
        :currency => "usd",
        :card => token,
        :description => self.email
    )
  end

  def send_new_user_emails
    UserMailer.delay.new_user_notice(self)
    UserMailer.delay.new_user_confirmation(self)
  end

  def create_confirm_token
    self.confirm_token = SecureRandom.urlsafe_base64
  end

  def make_admin
    self.admin = true
  end

  def inactivate_user
    self.active = false
  end

  def activate_user
    self.active = true
    self.confirm_token = nil
    self.anniversary = self.created_at.next_year
  end

  def feed
    #Micropost.find_by_user_id
    Micropost.from_users_followed_by(self)
  end

  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  private
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

    def generate_token
      SecureRandom.urlsafe_base64
    end

    def update_expiry
      self.update_attribute('anniversary', Date.today.next_year )
    end
end
