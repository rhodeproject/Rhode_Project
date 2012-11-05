module EventsHelper
  def show_day(sdate)
    DateTime.strptime(sdate.to_s, '%Y-%m-%d %H:%M:%S' ).strftime('%A %m/%d/%Y %H:%M %p')
  end

  def signed_up?
    @event = Event.find(params[:id])
    @event.users.where(:id => current_user.id).present?
  end
end
