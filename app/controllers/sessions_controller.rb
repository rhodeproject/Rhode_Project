class SessionsController < ApplicationController
  before_filter :check_expiry, :only => :create
  before_filter :check_active, :only => :create
  #before_filter :check_active_club, :only => :create
  def new
  end

  def create
    @user = User.find_by_email_and_club_id(params[:session][:email].downcase, find_club(request.subdomain))
    club = Club.find_by_sub_domain(request.subdomain)
   if @user && @user.authenticate(params[:session][:password]) && @user.active? && @user.club_id == club.id
     sign_in @user
      redirect_back_or root_path
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
   end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

  private
  def find_club(subdomain)
    club = Club.find_by_sub_domain(subdomain)
    club.id
  end

  def check_active
    @user = User.find_by_email_and_club_id(params[:session][:email], find_club(request.subdomain))
    unless @user.nil?
      unless @user.active?
        #flash[:warning] = "your account is inactive, check your email for activation or renewal notice!"
        redirect_to "/renew_users/#{@user.id}-#{@user.name.parameterize}"
      end
    end
  end

  def check_expiry
    @user = User.find_by_email_and_club_id(params[:session][:email], find_club(request.subdomain))
    unless @user.nil?
      if @user.anniversary.past?
        @user.inactivate_user
      end
    end
  end


  def check_active_club
    unless current_clubactive?
      flash[:warning] = "#{current_club.name} is currently inactive"
      redirect_to root_path
    end
  end

end
