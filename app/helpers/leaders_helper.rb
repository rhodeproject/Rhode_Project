module LeadersHelper

  def selected_default(leader)
    unless leader.user.nil?
      leader.user.id
    end
  end

  def render_title(leader)
    content_tag(:h3, "#{leader.real_name} - #{leader.title}")
  end
end


