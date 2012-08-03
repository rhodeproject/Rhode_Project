class ClubsController < ApplicationController

  def new
    @club = Club.new
  end

  def create
    user = User.new(params[:club][:user])
    user.update_attribute('admin', true)
    @club = Club.new
    @club.name = params[:club][:name]
    @club.sub_domain = params[:club][:sub_domain]
    if @club.save
      user.club_id = @club.id
      if user.save
        flash[:success] = "Thank you for adding your club to the Rhode Project"
        #sign_in user
        if Rails.env.development?
          redirect_to "http://#{@club.sub_domain}.lvh.me:3000/subscriptions/new"
        else
          redirect_to "https://#{@club.sub_domain}.rhodeproject.com/subscriptions/new"
        end
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
    if signed_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page], :per_page => 3 )
    end
  end

  def index
    if current_user.email == "mhatch73@gmail.com"
      @clubs = Club.all
    else
      flash[:warning] = "You are not the Admin"
      redirect_to root_path
    end
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
      if @club.update_attributes(params[:club])
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


end
