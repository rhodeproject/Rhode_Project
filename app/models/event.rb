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

  attr_accessible :starts_at, :ends_at, :title, :all_day, :description, :limit
  #before_save :convert_time
  #associations
  belongs_to :club
  has_many  :lists, :dependent => :destroy
  has_many :users, :through => :lists

  #validations
  validates :title, :presence => true
  validates :starts_at, :presence => true
  validates :ends_at, :presence => true, :format => RhodeProject::VALID_DATE_REGEX

  #scopes
  scope :before, lambda {|end_time| {:conditions => ["ends_at < ?", Event.format_date(end_time)] }}
  scope :after, lambda {|start_time| {:conditions => ["starts_at > ?", Event.format_date(start_time)] }}

  def to_param
    "#{id} #{title}".parameterize
  end

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

  def available_spots
    self.limit - self.lists.where(:state => RhodeProject::SIGNED_UP).count
  end

  def waiting
    self.lists.where(:state => RhodeProject::WAITING).count
  end

  def signed_up
    self.lists.where(:state => RhodeProject::SIGNED_UP).count
  end

  def add_user(user)
    if self.limit.nil?
      state = RhodeProject::SIGNED_UP
    else
      if self.available_spots > 0 || self.limit.nil?
        state = RhodeProject::SIGNED_UP
      else
        state = RhodeProject::WAITING
      end
    end

    if self.users << user
      @list = user.lists.find_by_event_id(self.id)
      @list.update_attribute("state", state)
      flash = "#{user.name} has been signed up for #{self.title}"
    else
      flash = "There was an issue adding #{user.name} to #{self.title}"
    end
    flash
  end

  def remove_user(user)
    list = self.lists.where(:user_id => user.id)
    if list[0].state != RhodeProject::WAITING
      check_wait_list
    end
    if self.users.delete(user)
      flash = "#{user.name} has been removed from #{self.title}"
    else
      flash = "There was an issue removing #{user.name} from #{self.title}"
    end
    flash
  end

  def check_wait_list
    list = self.lists.where(:state => RhodeProject::WAITING).order('updated_at ASC')
    if list.count > 0
      list[0].update_attribute('state', RhodeProject::WAITING)
    end
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


