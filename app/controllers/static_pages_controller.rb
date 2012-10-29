class StaticPagesController < ApplicationController
  def home
    @user = User.new

    if signed_in?
      @sponsors = Sponsor.scoped_by_club_id(current_user.club_id)
      @notices = Notice.scoped_by_club_id(current_user.club_id).order('created_at DESC').first(3)
    end
    sub_domain = request.subdomain
    if sub_domain.nil?
      @club = Club.find_by_sub_domain(sub_domain)
    else
      @club = Club.find_by_sub_domain('www')
    end

  end

  def help
  end

  def sponsors
    @sponsors = Sponsor.soped_by_club_id(current_user.club_id)
  end

  def about
  end

  def contact
  end
end
