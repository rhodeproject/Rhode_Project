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
        flash[:success] = "Welcome back #{user.name}"
        redirect_back_or root_path
      else
        # Create an error message and re-render the signin form.
        flash.now[:error] = 'Invalid email/password combination' # Not quite right!
        render 'new'
      end
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
