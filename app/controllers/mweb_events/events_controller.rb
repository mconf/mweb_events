module MwebEvents
  class EventsController < ApplicationController
    layout "mweb_events/application"
    load_and_authorize_resource :find_by => :permalink

    def index
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @events }
      end
    end

    def show
      @participant = Participant.new

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
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @event }
      end
    end

    def edit
    end

    def create
      @event = Event.new(params[:event])

      respond_to do |format|
        if @event.save
          format.html { redirect_to @event, notice: 'Event was successfully created.' }
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
          format.html { redirect_to @event, notice: 'Event was successfully updated.' }
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
  end
end
