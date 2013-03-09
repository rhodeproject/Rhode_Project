class StaticPagesController < ApplicationController
  def home
    #TODO:if the subdomain is www then act as a marketing page

    #btnText and id
    @btntext = "create my account"
    @btnid = "btnNewUser"
    @user = User.new

    if signed_in?
      @sponsors = Sponsor.scoped_by_club_id(current_club.id)
      @notices = Notice.scoped_by_club_id(current_user.club_id).order('created_at DESC').first(2)
      #@events = Event.scoped_by_club_id(current_club.id).first(3)
      #@topics = Topic(current_club.id).includes(:forum).last(3)
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
    @sponsors = Sponsor.scoped_by_club_id(current_club.id)
  end

  def about
  end

  def contact
  end
end
