module MwebEvents
  class ParticipantsController < ApplicationController
    layout "mweb_events/application"
    load_and_authorize_resource :event, :class => MwebEvents::Event, :find_by => :permalink
    load_and_authorize_resource :participant, :class => MwebEvents::Participant, :through => :event

    def index
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @participants }
      end
    end

    def show
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @participant }
      end
    end

    def new
      email = current_user && current_user.email
      @participant.email = email

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @participant }
      end
    end

    def edit
    end

    def create
      @participant.event = @event
      @participant.owner = current_user

      respond_to do |format|
        if @participant.save
          format.html { redirect_to @event, notice: t('participant.created') }
          format.json { render json: @participant, status: :created, location: @participant }
        else
          format.html { render action: "new" }
          format.json { render json: @participant.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @participant.destroy

      respond_to do |format|
        format.html { redirect_to event_participants_path(@event) }
        format.json { head :no_content }
      end
    end

  end
end
