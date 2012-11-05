class Event < ActiveRecord::Base
  # == Schema Information
  #
  # Table name: events
  #
  #  id          :integer         not null, primary key
  #  name        :string(255)
  #  all_day     :boolean         default(FALSE)
  #  created_at  :datetime        not null
  #  updated_at  :datetime        not null
  #  club_id     :integer
  #  title       :string(255)
  #  description :text
  #  starts_at   :datetime
  #  ends_at     :datetime
  #

  #CONSTANTS
  VALID_DATE_REGEX = /(0[1-9]|[12][0-9]|3[01])/
  attr_accessible :starts_at, :ends_at, :title, :all_day, :description
  #before_save :convert_time
  #associations
  belongs_to :club
  has_many  :lists, dependent: :destroy
  has_many :users, :through => :lists

  #validations
  validates :title, presence: true
  validates :starts_at, presence: true
  validates :ends_at, presence: true, :format => VALID_DATE_REGEX

  #scopes
  scope :before, lambda {|end_time| {:conditions => ["ends_at < ?", Event.format_date(end_time)] }}
  scope :after, lambda {|start_time| {:conditions => ["starts_at > ?", Event.format_date(start_time)] }}

  #callbacks

  # need to override the json view to return what full_calendar is expecting.
  # http://arshaw.com/fullcalendar/docs/event_data/Event_Object/
  def as_json(options = {})
    {
        :id => self.id,
        :title => self.title,
        :description => self.description || "",
        :start => starts_at,
        :end => ends_at,
        :allDay => self.all_day,
        :recurring => false,
        :url => Rails.application.routes.url_helpers.event_path(id)
    }
  end

  def add_user(user)
    if self.users << user
      @list = user.lists.find_by_event_id(self.id)
      @list.update_attribute("state", "Signed Up")
      flash = "You are signed up for #{self.title}"
    else
      flash = "There was an issue adding you to #{self.title}"
    end
    flash
  end

  def remove_user(user)
    if self.users.delete(user)
      flash = "You have been removed from #{self.title}"
    else
      flash = "There was an issue removing you from #{self.title}"
    end
    flash
  end

  def signed_up?(user)
    self.users.where(:id => user.id).present?
  end

  def self.format_date(date_time)
    Time.at(date_time.to_i).to_formatted_s(:db)
  end

  def convert_time(time)
    time.utc
  end


end


