class EventsController < ApplicationController
  def new
    @events = Event.new
  end

  def create
    @events = Event.new(params[:event])
    @events.update_attribute('club_id', current_user.club.id)
    if @events.save
      flash[:success] = "#{@events.name} has been added to the Calendar"
      redirect_to '/calendar'
    end
  end

  def index
    #list all events
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end
end
