# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password

  #Data Relationships
  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through:  :relationships, source: :followed
  has_many :posts
  has_many :topics
  has_and_belongs_to_many :forums

  #reverse relationship
  has_many :reverse_relationships, foreign_key: "followed_id",
           class_name:  "Relationship",
           dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  #repeated code -- commented 4/24 --
  #before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  #convert email to Lowercase to ensure uniqueness in the DB
  before_save { |user| user.email = email.downcase}

  #user validation
  validates :name, presence: true, length:{maximum: 50}

  #email validation
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}

  #password validation
  validates :password, length: {minimum: 6}

  #password_confirmation validation
  validates :password_confirmation, presence: true

  #scopes
  scope :admin, where(admin: true)

  #methods
  def send_password_reset
    #generate_token(:reset_token)
    self.update_attribute('reset_token', generate_token)
    self.update_attribute('password_reset_sent_at', Time.zone.now)
    #self.reset_token = SecureRandom.urlsafe_base64
    #self.password_reset_sent_at = Time.zone.now
    #save!
    UserMailer.password_reset(self).deliver
  end

  def feed
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
end
