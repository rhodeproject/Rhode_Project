class NoticesController < ApplicationController
  def new
    @notice = Notice.new
  end

  def create
    @notice = Notice.new(params[:notice])
    @notice.update_attribute('club_id', current_user.club.id)
    if @notice.save
      flash[:success] = "Notice Added!"
    else
      flash[:success] = "Failed to add Notice"
    end
    redirect_to notices_path
  end

  def index
    @notices = Notice.where(:club_id => current_user.club_id)
    @notice = Notice.new
  end

  def edit

  end
end
