class UsersController < ApplicationController
  before_filter :signed_in_user, :only => [:index, :show]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :correct_club, :only => :show
  #before_filter :sign_in_check, :only => :new
  before_filter :destroy_check, :only => :destroy
  before_filter :admin_check, :only => :destroy

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.scoped_by_club_id(current_club.id)
  end

  def new
    @user = User.new
    @club = Club.find_by_sub_domain(request.subdomain)
  end

  def create
    club = Club.find_by_sub_domain(request.subdomain)
    @user = club.users.build(params[:user])
    if club.fee.nil? #if club charges membership, process the card
      message = @user.create_confirm_token #user will be saved
    else #else create confirm token
      token = params[:stripeToken]
      message = @user.pay_membership_fee(token) #user will be saved
      sign_in_first_time @user
    end

    flash[:success] = message
    redirect_to root_path

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
    if @user.update_attribute(:admin, params[:user][:admin]) &&
      @user.update_attribute(:name, params[:user][:name]) &&
      @user.update_attribute(:email, params[:user][:email]) &&
      @user.update_attribute(:active, params[:user][:active])
      flash[:success] = "Profile updated"
      redirect_to users_path
    else
      render 'edit'
    end
  end

  def destroy
    @user =  User.find(params[:id])
    if @user.active?
      @user.disable
      flash[:success] = "User #{@user.name} has been disabled!"
    else
      @user.destroy  unless @user == current_user
      flash[:success] = "User #{@user.name} removed."
    end
    redirect_to users_path
  end

  #Private Functions
  private

    def correct_user
      @user = User.find(params[:id])
      unless current_user?(@user) || current_user.admin?
        flash[:warning] = "you are not able to make this change"
        redirect_to(root_path)
      end
    end

  def correct_club
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_club.id == @user.club_id
  end

  def sign_in_check
    redirect_to(root_path) unless signed_in?
  end

  def admin_check
    unless current_user.admin?
      flash[:warning] = "you cannot make this change"
      redirect_to(root_path)
    end
  end

  def destroy_check
    if current_user == User.find(params[:id])
      flash[:warning] = "you can't remove yourself"
      redirect_to users_path
    end
  end
end



