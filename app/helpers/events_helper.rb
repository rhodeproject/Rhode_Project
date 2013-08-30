module EventsHelper
  def signed_up?
    @event = Event.find(params[:id])
    @event.users.where(:id => current_user.id).present?
  end

  def render_signedup(e)
    unless e.limit.nil?
      content_tag(:div, "#{pluralize(e.available_spots, 'spot')} available") if e.available_spots > -1
    else
      content_tag(:div, "there is no limit for this event")
    end
  end

  def render_waiting(e)
    unless e.limit.nil?
      content_tag(:div, "#{pluralize(e.waiting, 'member')} on waiting list") if e.available_spots < 0
    end
  end

  def render_limit(e)
    unless e.limit.nil?
      content_tag(:div, "limit -- #{e.limit}")
    end
  end
end
