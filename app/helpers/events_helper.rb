module EventsHelper
  def signed_up?
    @event = Event.find(params[:id])
    @event.users.where(:id => current_user.id).present?
  end
end
