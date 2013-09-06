module LeadersHelper

  def selected_default(leader)
    unless leader.user.nil?
      leader.user.id
    end
  end
end
