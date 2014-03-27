module ApplicationHelper
  #Returns the full title on a per-page  basis
  def full_title(page_title)
    if signed_in?
      base_title = "#{current_user.club.name} | #{current_user.name.html_safe}"#current_user.club.name
    else
      base_title = "The Rhode Project"
    end

    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def club_url(subdomain)
    if subdomain == ''
      subdomain = 'www'
    end
    Club.find_by_sub_domain(subdomain)
  end

  def url_with_protocol(url)
    /^http/.match(url) ? url : "http://#{url}"
  end

  def show_date(date)
    date.in_time_zone("Eastern Time (US & Canada)").strftime("%m/%d/%Y") unless date.nil?
  end

  def show_date_with_time(date_time)
    date_time.in_time_zone("Eastern Time (US & Canada)").strftime("%m/%d/%Y %I:%M:%S %p") unless date_time.nil?
  end

  def show_day(sdate)
    DateTime.strptime(sdate.to_s, '%Y-%m-%d %H:%M:%S' ).strftime('%A %m/%d/%Y %l:%M %p')
  end

  def render_addthis_follow
    render(:template => 'shared/_addthis_follow.html.erb')
  end

  def render_addthis_share
    render(:template => 'shared/_addthis_share.html.erb')
  end
end
