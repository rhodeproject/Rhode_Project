class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page], :per_page => 3 )
      @notices = Notice.where(:club_id => current_user.club_id).paginate(page: params[:page], :per_page => 3).order('created_at DESC')
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

  def about
  end

  def contact
  end
end
