class ClubsController < ApplicationController
  before_filter :signed_in_user, :only => [:show, :edit, :update]
  before_filter :admin_check, :only => [:edit, :update, :payments,:charge]
  before_filter :god_check, :only => [:index]

  def new
    @club = Club.new
  end

  def create
    @club = Club.new
    @club.name = params[:club][:name]
    @club.sub_domain = params[:club][:sub_domain]
    @club.fee = params[:club][:fee]
    @club.stripe_api_key = params[:club][:stripe_api_key]
    @club.stripe_publishable_key = params[:club][:stripe_publishable_key]
    @club.contact_email = params[:club][:user][:email]
    if @club.save
      user = @club.users.build(params[:club][:user])#.club_id = @club.id
      user.make_admin
      if user.save
        flash[:success] = "Thank you for adding your club to the Rhode Project"

        #sign_in user
        redirect_to "#{Figaro.env.protocol}#{@club.sub_domain}.#{Figaro.env.base_url}/subscriptions/new"
      else
        flash[:warning] = "failed to create user"
        redirect_to root_path
      end
    else
      flash[:warning] = "failed to created club"
      redirect_to root_path
    end
  end

  def show
    @club = Club.find_by_sub_domain!(request.subdomain)
  end

  def index
   @clubs = Club.all
  end

  def edit
    if current_user.admin?
      @club = Club.find(params[:id])
    else
      flash[:warning] = "You do not have rights to edit this club"
      redirect_to root_path
    end
  end

  def update
    if current_user.admin?
      @club = Club.find(params[:id])
      @club.update_attributes(params[:club])
      @club.fee = params[:club][:fee].gsub(/\D/, '').to_i #refactor to model

      if @club.save
        flash[:success] = "Changes to #{@club.name} have been saved!"
        redirect_to root_path
      else
        render 'edit'
      end
    else
      flash[:warning] = "You do not have rights to edit this club"
      redirect_to root_path
    end
  end

  def contact
    #use this action to submit contact form and send an email
    @club = Club.find_by_sub_domain(request.subdomain)
    content = params[:message]
    sender_name = params[:name]
    sender_email = params[:email]
    @club.send_contact_email(content,sender_email,sender_name)

    respond_to do |format|
      format.json {render :json => root_path }
      format.js {render :js => root_path}
    end
  end

  def validation
    #used for remote validation calls
    #return true if the club url is already used by another club

    @club = Club.find_by_sub_domain(params[:club][:sub_domain])
    if @club.nil?
      @return = true
    else
      @return = false
    end
    respond_to do |format|
      format.js {render :json => @return}
    end
  end

  def payments
    #retrieve current_club payments
    @club = Club.find_by_sub_domain(request.subdomain)
    start_date = Time.parse(params[:start_date]).to_i unless params[:start_date].nil?
    end_date = Time.parse(params[:end_date]).to_i unless params[:end_date].nil?
    @payments = @club.payments(start_date,end_date)[:data]
  end

  def charge
    @charge = current_club.charge(params[:charge])
    respond_to do |format|
      format.js {render :json => @charge}
    end
  end

  def refund
    @refund = current_club.refund(params[:refund])
    respond_to do |format|
      format.js {render :json => @refund}
    end
  end

  def stripesubscription
    @subscription = current_club.stripesubscription(params[:subscription])
    respond_to do |format|
      format.js {render :json => @subscription}
    end
  end

  private

  def god_check
    unless current_user.email == Figaro.env.god_account
      redirect_to root_path
    end
  end

  def admin_check
    unless current_user.admin?
      flash[:warning] = "you are not permitted to take this action"
      redirect_to(root_path)
    end
  end
end
