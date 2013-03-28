class SponsorsController < ApplicationController
  before_filter :check_admin, :only => [:create, :edit, :destroy, :update]
  before_filter :correct_club, :only => [:create, :edit, :destroy, :update]

  def index
    @sponsors = Sponsor.scoped_by_club_id(current_club.id).group("id","label").order("priority")
    @atom_sponsors = Sponsor.scoped_by_club_id(current_club.id)
    @sponsor = Sponsor.new
  end

  def new
    @sponsor = Sponser.new
  end

  def create
    @sponsor = current_club.sponsors.build(params[:sponsor])
    if @sponsor.save
      flash[:success] = "Sponsor Added to #{current_club.name}"
      redirect_to sponsors_path
    else
      flash[:waring] = "There was an issue adding sponsor"
      redirect_to sponsors_path
    end
  end

  def edit
      @sponsor = Sponsor.find(params[:id])
  end

  def update
    @sponsor = Sponsor.find(params[:id])
    @sponsor.update_attributes(params[:sponsor])
    if @sponsor.save
      flash[:success] = "sponsor updated"
      redirect_to sponsors_path
    end
  end

  def destroy
    @remove = Sponsor.find(params[:id])
    @remove.destroy
    flash[:danger] = "sponsor removed"
    redirect_to sponsors_path
  end

  private

  def check_admin
    unless current_user.admin?
      flash[:waring] = "You are not able to perform this action"
      redirect_to root_path
    end
  end

  def correct_club
    unless current_user.club == current_club
      flash[:waring] = "You are not able to perform this action"
      redirect_to root_path
    end
  end
end
