class Profile < ActiveRecord::Base
  attr_accessible :age, :bio, :blog, :user_id, :econtact_name, :econtact_number
  before_save :convert_phone_number

  private

  def convert_phone_number
    self.econtact_number = self.econtact_number.gsub(/\D/,'')
  end

end
