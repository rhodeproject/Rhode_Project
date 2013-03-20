module ProfilesHelper
  def default_month
    unless current_user.profile.nil?
      current_user.profile.dob.month unless current_user.profile.dob.nil?
    end
  end

  def default_day
    unless current_user.profile.nil?
      current_user.profile.dob.day unless current_user.profile.dob.nil?
    end
  end

  def default_year
    unless current_user.profile.nil?
      current_user.profile.dob.year unless current_user.profile.dob.nil?
    end
  end
end
