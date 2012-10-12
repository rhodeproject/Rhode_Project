class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy

  def show
    @user = User.find(params[:id])
    if current_user.club_id == @user.club_id
      @microposts = @user.microposts.paginate(page: params[:page], :per_page => 5)
    else
      flash[:warning] = "you cannot view this user"
      redirect_to '/users'
    end
  end

  def index
    @users = User.where('club_id = ?',current_user.club_id)
  end

  def new
    if signed_in?
      flash[:success] = "You are already signed in."
      redirect_to root_path
    end
    @user = User.new
    @club = Club.find_by_sub_domain(request.subdomain)
  end

  def create
    club = Club.find_by_sub_domain(request.subdomain)
    @user = club.users.build(params[:user])
    @user.create_confirm_token
    token = params[:stripeToken]

    @user.pay_membership_fee(token)
    if @user.save
      flash[:success] = "Welcome to #{club.name}! A confirmation email has been sent to #{@user.email}.
                        Follow the link in the email to activate your account."
      @user.send_new_user_emails
      redirect_to root_path
    else
      render 'new'
    end
  end

  def confirm
    @user = User.find(params[:id])
    if @user.confirm_token == params[:confirm_code]
      @user.activate_user
      flash[:success] = "You account has been activated"
      sign_in(@user)
      redirect_to @user
    else
      flash[:warning] = "Account activation failed"
      redirect_to root_path
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @remove =  User.find(params[:id])
    if @remove == current_user
      flash[:success] = "You cannot remove yourself"
      redirect_to users_path
    else
      if current_user.admin?
        @remove.destroy  unless @remove == current_user
        flash[:success] = "User #{@remove.name} removed."
        redirect_to users_path
      else
        flash[:warning] = "you cannot remove this user"
        redirect_to '/users'
      end
    end
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  #Private Functions
  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to root_path unless current_user.admin?
    end

end


