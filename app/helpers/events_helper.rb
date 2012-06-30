module EventsHelper
  def show_day(sdate)
    DateTime.strptime(sdate.to_s, '%Y-%m-%d %H:%M:%S' ).strftime('%A %m/%d/%Y %H:%M %p')
  end
end
