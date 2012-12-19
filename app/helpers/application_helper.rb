module ApplicationHelper
  #Returns the full title on a per-page  basis
  def full_title(page_title)
    if signed_in?
      base_title = current_user.club.name
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

  def show_date(date)
    date.in_time_zone("Eastern Time (US & Canada)").strftime("%m/%d/%Y")
  end

  def show_date_with_time(date_time)
    date_time.in_time_zone("Eastern Time (US & Canada)").strftime("%m/%d/%Y %I:%M:%S %p")
  end
end
