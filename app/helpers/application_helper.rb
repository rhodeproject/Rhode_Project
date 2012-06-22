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
    Club.find_by_sub_domain(subdomain)
  end


end
