class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:session][:email])
    if user.active?
      club = Club.find_by_sub_domain(request.subdomain)
      if user.club_id != club.id
        flash[:warning] = "There is an issue signing you into #{club.name}"
        redirect_to root_path
      else
       if user && user.authenticate(params[:session][:password])
         sign_in user
          redirect_back_or root_path
        else
          flash.now[:error] = 'Invalid email/password combination'
          render 'new'
       end
      end
    else
      flash[:warning] = "Your account is not active. Check your inbox for confirmation email!"
      render('users/renew')
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

end
