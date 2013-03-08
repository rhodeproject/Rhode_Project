class Profile < ActiveRecord::Base
  attr_accessible :age, :bio, :blog, :user_id, :econtact_name, :econtact_number
  before_save :convert_phone_number

  #TODO:
  #add several items: full/real name, gender, t-shirt size, birthdate, physical address, home phone
  #T-Shirt size XS,S,M,L,XL,XXL
  #real_name
  #gender
  #shirt_size
  #birth_date
  #physical_address
  #contact_number

  #drop Age

  private

  def convert_phone_number
    self.econtact_number = self.econtact_number.gsub(/\D/,'') unless self.econtact_number.nil?
  end

end
