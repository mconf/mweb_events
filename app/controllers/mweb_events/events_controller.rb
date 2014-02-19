module MwebEvents
  class EventsController < ApplicationController
    layout "mweb_events/application"
    before_filter :load_events_in_order, :only => [:index]
    load_and_authorize_resource :find_by => :permalink

    respond_to :json

    def index

      if params[:show] == 'happening_now'
        @events = @events.happening_now
      elsif params[:show] == 'past_events'
        @events = @events.past.reverse!
      elsif params[:show] == 'all'
        # no filtering
      elsif params[:show] == 'upcoming_events' or !params[:show] #default case
        @events = @events.upcoming
      end

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @events }
      end
    end

    def show
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @event }

        format.ics do
          calendar = Icalendar::Calendar.new
          calendar.add_event(@event.to_ics)
          calendar.publish
          render :text => calendar.to_ical
        end

      end
    end

    def new

      if params[:owner_id] && params[:owner_type]
        @event.owner_id = params[:owner_id]
        @event.owner_type = params[:owner_type]
      else
        @event.owner_name = current_user.try(:email)
      end

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @event }
      end
    end

    def edit
    end

    def create
      @event = Event.new(params[:event])

      if @event.owner.nil?
        @event.owner = current_user
      end

      respond_to do |format|
        if @event.save
          format.html { redirect_to @event, notice: t('mweb_events.event.created') }
          format.json { render json: @event, status: :created, location: @event }
        else
          format.html { render action: "new" }
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @event.update_attributes(params[:event])
          format.html { redirect_to @event, notice: t('mweb_events.event.updated') }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @event.destroy

      respond_to do |format|
        format.html { redirect_to events_url }
        format.json { head :no_content }
      end
    end

    # Finds events by name (params[:q]) and returns a list of selected attributes
    def select
      name = params[:q]
      limit = params[:limit] || 5
      limit = 50 if limit.to_i > 50
      if name.blank?
        @events = Event.limit(limit).all
      else
        @events = Event.where("name like ?", "%#{name}%").limit(limit)
      end

      respond_with @events do |format|
        format.json
      end
    end

    private

    def load_events_in_order
      @events = Event.order "start_on ASC"
    end

  end
end
