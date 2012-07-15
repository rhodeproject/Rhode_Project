class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:session][:email])
    club = Club.find_by_sub_domain(request.subdomain)
    if user.club_id != club.id
      flash[:warning] = "There is an issue signing you into #{club.name}"
      redirect_to root_path
    else
     if user  && user.authenticate(params[:session][:password])
        sign_in user
        update_admins user
        flash[:success] = "Welcome back #{user.name}"
        redirect_back_or root_path
      else
        flash.now[:error] = 'Invalid email/password combination'
        render 'new'
      end
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

  private

  def update_admins(user)
    admins = User.all( :conditions => ['club_id = ? and admin = ?', user.club_id, true])#.where(:admin => true)
    admins.each do |a|
      if a.admin?
        user.follow!(a) unless user.following?(a)
      end

    end
  end

end
