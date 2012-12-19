class NoticesController < ApplicationController
  before_filter :admin_user, :only => :create

  def new
    @notice = Notice.new
  end

  def create

    @notice = current_club.notices.build(params[:notice])
    if @notice.save
      @notice.send_tweet(current_club) if params[:tweet] == "1"
      @notice.send_email(current_club) if params[:email] == "1"
      flash[:success] = "Notice Added!"
    else
      flash[:success] = "Failed to add Notice"
    end
    redirect_to notices_path
  end

  def index
    @notices = Notice.scoped_by_club_id(current_club).order('updated_at DESC')
    @notice = Notice.new
  end

  def edit
    @notice = Notice.find(params[:id])
  end

  def update
    @notice = Notice.find(params[:id])
    @notice.update_attributes(params[:notice])
    if @notice.save
      @notice.send_tweet(current_club) if params[:tweet] == "1"
      @notice.send_email(current_club) if params[:email] == "1"
      flash[:success] = "notice updated!"
      redirect_to notices_path
    else
      flash[:warning] = "there was an issue editing the notice"
      redirect_to notices_path
    end
  end

  def destroy
    @remove = Notice.find(params[:id])
    @remove.destroy
    flash[:success] = "notice removed"
    redirect_to notices_path
  end

  private

  def admin_user
    unless current_user.admin
      flash[:warning] = "you aren't able to add new notices!"
      redirect_to notices_path
    end
  end
end
