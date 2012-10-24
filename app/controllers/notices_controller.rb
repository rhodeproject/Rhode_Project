class NoticesController < ApplicationController
  def new
    @notice = Notice.new
  end

  def create
    club = Club.find(current_user.club.id)
    @notice = club.notices.build(params[:notice])
    if @notice.save
      @notice.send_tweet(club)
      flash[:success] = "Notice Added!"
    else
      flash[:success] = "Failed to add Notice"
    end
    redirect_to notices_path
  end

  def index
    @notices = Notice.scoped_by_club_id(current_user.club_id).order('updated_at DESC')
    @notice = Notice.new
  end

  def edit

  end
end
