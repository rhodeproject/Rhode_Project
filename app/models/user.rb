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
  attr_accessible :email, :name, :password, :password_confirmation, :club_id,:referral_count
  has_secure_password

  #Data Relationships
  has_many :microposts, :dependent => :destroy
  has_many :relationships, :foreign_key => "follower_id", :dependent => :destroy
  has_many :followed_users, :through =>  :relationships, :source => :followed
  has_many :posts
  has_many :topics
  belongs_to :club
  has_and_belongs_to_many :forums
  has_one :profile
  has_many :lists, :dependent => :destroy
  has_many :events, :through => :lists
  has_many :leaders


  #reverse relationship
  has_many :reverse_relationships, :foreign_key => "followed_id",
           :class_name =>  "Relationship",
           :dependent =>   :destroy
  has_many :followers, :through => :reverse_relationships, :source => :follower

  before_save :create_remember_token

  #convert email to Lowercase to ensure uniqueness in the DB
  before_save { |user| user.email = email.downcase}


  #create expiry date
  after_create :update_expiry

  #user validation
  validates :name, :presence => true, :length => {:maximum => 50}

  #email validation
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :presence => true,
            :format => {:with => VALID_EMAIL_REGEX}

  validates_uniqueness_of :email, :scope => :club_id
  #password validation
  validates :password, :length => {:minimum => 6}

  #password_confirmation validation
  validates :password_confirmation, :presence => true

  #scopes
  scope :admin, where(:admin => true)
  scope :by_name, {:order => "lower(name) ASC"}
  scope :active_users, where(:active => true)

  #methods
  def to_param
    "#{id} #{name}".parameterize
  end

  def active?
    self.active
  end

  def active_css_class
    if self.active
      result = "active"
    else
      result = "inactive"
    end
    result
  end

  def active_yes_no

    if self.active
      result = "yes"
    else
      result = "no"
    end
    result
  end

  def admin?
    self.admin
  end

  def md5_email
    Digest::MD5::hexdigest(self.email.downcase)
  end

  def send_password_reset
    self.update_attribute('reset_token', generate_token)
    self.update_attribute('password_reset_sent_at', Time.zone.now)
    UserMailer.delay.password_reset(self)
  end

  def pay_membership_fee(token)
    charge = create_stripe_charge(token)
    self.stripe_id = charge[:id]
    save!
    if charge[:paid] && charge[:card][:cvc_check] != "fail"
      activate_user
      send_payment_confirmation
      "Thank you for joining #{self.club.name}!  Your payment has been processed successfully!"
    else
      "The follow error occured: #{charge[:failure_message]}"
    end
  end

  def renew_membership_fee(token)

    #check if the expiry date has past, if it has new expiry should be a year from today
    #else it should be a year from previous anniversary
    unless anniversary.nil?
      if anniversary.past?
        new_anniversary = Date.today.next_year
      else
        new_anniversary = anniversary.next_year
      end
    else
      new_anniversary = Date.today.next_year
    end

    charge = create_stripe_charge(token)
    self.update_attribute('stripe_id',charge[:id])
    self.update_attribute('anniversary', new_anniversary)
    self.update_attribute('active', true)
    send_payment_confirmation
    "Thank's for renewing!  Your payment has been processed successfully!"
  end

  def send_new_user_emails
    UserMailer.delay.new_user_notice(self)
    UserMailer.delay.new_user_confirmation(self)
  end

  #send welcome email to new user
  def send_welcome_email
    UserMailer.delay.welcome_email(self)
  end

  def create_confirm_token
    self.confirm_token = SecureRandom.urlsafe_base64
    self.save!
    self.send_new_user_emails
    "An email has been sent to #{self.email}. Please follow the link to confirm your account."
  end

  def make_admin
    self.admin = true
    self.active = true unless self.active? #always activate the user if they are an admin - this is for initial club set up
  end

  #depricate this method
  def inactivate_user
    self.update_attribute('active',false)
  end

  def disable
    self.update_attribute('active',false)
  end

  def activate_user
    #TODO: make this work for a renewal
    self.active = true
    self.confirm_token = nil
    self.anniversary = self.created_at.next_year
    if valid?
      save!
    end
  end

  def get_slot_state(event_id)
    list = self.lists.find_by_event_id(event_id)
    list.state
  end

  def add_referral
    #check if the current value is nil
    if self.referral_count.nil?
      referrals = 0
    else
      referrals = self.referral_count
    end

    referrals = referrals + 1
    self.update_attribute('referral_count',referrals)
  end

  def referred_by(referrer)
    #find user whose name is a close macth to what is entered
    User.find.where("name like ?", referrer)
  end

  def age
    unless self.profile.dob.nil?
      ((Time.now - self.profile.dob)/1.year).floor
    end
  end

  def real_name
    unless profile.nil?
      unless self.profile.full_name.nil?
        name = self.profile.full_name
      else
        name = self.name
      end
    else
      name = self.name
    end

    name
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |user|
        csv << user.attributes.values_at(*column_names)
      end
    end
  end

  private

    def create_stripe_charge(token)
      Stripe.api_key = self.club.stripe_api_key
      Stripe::Charge.create(
          :amount => self.club.fee * 100, # amount in cents, again
          :currency => "usd",
          :card => token,
          :description => self.email
      )
    end

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

    def generate_token
      SecureRandom.urlsafe_base64
    end

    def update_expiry
      self.update_attribute('anniversary', Date.today.next_year )
    end

    def send_payment_confirmation
      UserMailer.delay.payment_confirmation(self)
    end
end
