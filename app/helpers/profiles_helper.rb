module ProfilesHelper
  def default_month
    current_user.profile.dob.month unless current_user.profile.dob.nil?
  end

  def default_day
    current_user.profile.dob.day unless current_user.profile.dob.nil?
  end

  def default_year
    current_user.profile.dob.year unless current_user.profile.dob.nil?
  end
end
