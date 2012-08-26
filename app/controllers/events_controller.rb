class EventsController < ApplicationController
  # GET /events
  # GET /events.xml
  def index
    # full_calendar will hit the index method with query parameters
    # 'start' and 'end' in order to filter the results for the
    # appropriate month/week/day.  It should be possiblt to change
    # this to be starts_at and ends_at to match rails conventions.
    # I'll eventually do that to make the demo a little cleaner.
    @events = Event.scoped_by_club_id(current_user.club_id)
    @events = @events.after(params['start']) if (params['start'])
    @events = @events.before(params['end']) if (params['end'])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
      format.js  { render :json => @events }
    end
  end

  # GET /events/1
  # GET /events/1.xml
  def show
    @event = Event.find(params[:id])
    if @event.club_id == current_user.club_id
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @event }
        format.js { render :json => @event.to_json }
      end
    else
      flash[:warning] = "You are not able to view this event"
      redirect_to '/calendar'
    end
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.xml
  def create
    @event = Event.new(params[:event])
    @event.club_id = current_user.club_id
    respond_to do |format|
      if @event.save
        add_event_notice(@event)
        format.html { redirect_to(calendar_path, :notice => 'Event was successfully created.') }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.xml
  # PUT /events/1.js
  # when we drag an event on the calendar (from day to day on the month view, or stretching
  # it on the week or day view), this method will be called to update the values.
  # viv la REST!
  def update
    @event = Event.find(params[:id])

    if current_user.club_id == @event.club_id
      respond_to do |format|
        if @event.update_attributes(params[:event])
          format.html { redirect_to(calendar_path, :notice => 'Event was successfully updated.') }
          format.xml  { head :ok }
          format.js { head :ok}
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
          format.js  { render :js => @event.errors, :status => :unprocessable_entity }
        end
      end
    else
      flash[:warning] = "you are not able to update this event"
      redirect_to '/calendar'
    end

  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event = Event.find(params[:id])

    if current_user.club_id == @event.club_id
      @event.destroy

      respond_to do |format|
        format.html { redirect_to(events_url) }
        format.xml  { head :ok }
      end
    else
      flash[:warning] = "You are not able to delete this event"
      redirect_to '/calendar'
    end

  end

  private
  def add_event_notice(event)
    content = "A new event,#{event.title}, has been added to the Club calendar on #{event.starts_at}"
    notice = Notice.new(:content => content)
    notice.update_attribute('club_id', current_user.club.id)
    notice.save
  end
end
