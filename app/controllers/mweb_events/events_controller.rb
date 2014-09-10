module MwebEvents
  class EventsController < ApplicationController
    layout "mweb_events/application"
    before_filter :concat_datetimes, :only => [:create, :update]
    load_and_authorize_resource :find_by => :permalink
    before_filter :set_date_locale, :only => [:new, :edit]

    respond_to :json

    def index

      if params[:show] == 'happening_now'
        @events = @events.happening_now.order('start_on ASC')
      elsif params[:show] == 'past_events'
        @events = @events.past.order('start_on DESC')
      elsif params[:show] == 'all'
        @events = @events.order('start_on DESC')
      elsif params[:show] == 'upcoming_events' or !params[:show] #default case
        @events = @events.upcoming.order('start_on ASC')
      end

      # Use query parameter to search for events
      if params[:q].present?
        @events = @events.where("name like ?", "%#{params[:q]}%")
      end

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @events }
      end
    end

    def show
      @time_zone = Time.zone

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
      @event = Event.new(event_params)

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
        if @event.update_attributes(event_params)
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
        format.html { redirect_to events_url, notice: t('mweb_events.event.destroyed') }
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

    def concat_datetimes
      if params[:event][:start_on_date].present?
        params[:event]['start_on_time(4i)'] ||= '00'
        params[:event]['start_on_time(5i)'] ||= '00'
        params[:event][:start_on_time] = "#{params[:event]['start_on_time(4i)']}:#{params[:event]['start_on_time(5i)']}"
      else
        params[:event][:start_on] = ''
      end

      if params[:event][:end_on_date].present?
        params[:event]['end_on_time(4i)'] ||= '00'
        params[:event]['end_on_time(5i)'] ||= '00'
        params[:event][:end_on_time] = "#{params[:event]['end_on_time(4i)']}:#{params[:event]['end_on_time(5i)']}"
      else
        params[:event][:end_on] = ''
      end

      (1..5).each { |n| params[:event].delete("start_on_time(#{n}i)") }
      (1..5).each { |n| params[:event].delete("end_on_time(#{n}i)") }
    end

    def set_date_locale
      # can be overriden by the application
      @date_locale = 'en'
      @date_format = 'MM-dd-yyyy'
      @event.date_stored_format = '%m/%d/%Y %H:%M %z'
      @event.date_display_format = '%m/%d/%Y'
    end

    private
    def event_params
      params.require(:event).permit(
        :address, :start_on_time, :start_on_date, :description,
        :location, :name, :time_zone, :end_on_time, :end_on_date,
        :social_networks, :summary, :owner_id, :owner_type, :start_on, :end_on, :date_stored_format
      )
    end

  end
end
