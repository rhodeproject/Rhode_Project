class Profile < ActiveRecord::Base
  attr_accessible :age,
                  :bio,
                  :blog,
                  :user_id,
                  :econtact_name,
                  :econtact_number,
                  :name_first,
                  :name_last,
                  :shirt_size,
                  :dob,
                  :contact_number

  before_save :convert_phone_number

  #TODO: add several items: full/real name, gender, t-shirt size, birthdate, physical address, home phone
  #gender
  #physical_address
  #drop Age

  def full_name
    "#{self.name_first} #{self.name_last}"
  end

  private

  def convert_phone_number
    self.econtact_number = self.econtact_number.gsub(/\D/,'') unless self.econtact_number.nil?
    self.contact_number = self.contact_number.gsub(/\D/,'') unless self.contact_number.nil?
  end


end
