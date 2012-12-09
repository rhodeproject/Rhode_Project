class SessionsController < ApplicationController
  before_filter :check_active, :only => :create
  def new
  end

  def create
    @user = User.find_by_email_and_club_id(params[:session][:email], find_club(request.subdomain))
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
    unless @user.active?
      flash[:warning] = "you account is inactive, check your email for activation or renewal notice!"
      redirect_to root_path
    end
  end
end
