require "spec_helper"

describe MwebEvents::EventsController do

  routes { MwebEvents::Engine.routes }

  describe "#index" do

    context "layout and view" do
      before(:each) { get :index }
      it { should render_template("mweb_events/events/index") }
    end

    it "assigns @events"

    # context "if params[:show] == 'past_events'" do
    #   it "assigns @past_events"
    # end
    # context "if params[:show] == 'upcoming_events'" do
    #   it "assigns @upcoming_events"
    # end
    # context "if params[:show] not set or invalid" do
    #   it "assigns @last_past_events"
    #   it "assigns @first_upcoming_events"
    # end
  end

  describe "#index.atom" do
    it "returns an rss with all the events available"
  end

  describe "#show.atom" do
    it "returns an rss with all the updates in the event"
  end

  describe "#show" do
    let(:event) { FactoryGirl.create(:event) }

    context "layout and view" do
      before(:each) { get :show, :id => event.to_param }
      it { should render_template("mweb_events/events/show") }
    end

    it "assigns @event"
    it "assigns @attendees with the users that confirmed attendance"
    it "assigns @not_attendees with the users that confirmed that will not attend"
  end

  describe "#new" do
    let(:owner) { FactoryGirl.create(:owner) }

    context "layout and view" do
      before(:each) { get :new }
      it { should render_template("mweb_events/events/new") }
    end

    it "assigns @event"
  end

  describe "#create" do
    let(:owner) { FactoryGirl.create(:owner) }
    before(:each) { sign_in(owner) }

    context "with valid attributes" do
      let(:event) { FactoryGirl.build(:event) }
      let(:attributes) { FactoryGirl.attributes_for(:event) }

      before(:each) {
        expect {
          post :create, :event => attributes
        }.to change(MwebEvents::Event, :count).by(1)
      }

      describe "creates the new event with the correct attributes" do
        # TODO: for some reason the matcher is not found, maybe we just need to update rspec and other gems
        pending { MwebEvents::Event.last.should have_same_attibutes_as(event) }
      end

      it "redirects to the new event" do
        should redirect_to(event_path(MwebEvents::Event.last))
      end

      it "assigns @event with the new event" do
        should assign_to(:event).with(MwebEvents::Event.last)
      end

      it "sets the flash with a success message" do
        should set_the_flash.to(I18n.t('mweb_events.event.created'))
      end

      it "sets the current user as the author" do
        # MwebEvents::Event.last.author.should eq(user)
      end

    end

    context "with invalid attributes" do
      let(:invalid_attributes) { FactoryGirl.attributes_for(:event, :name => nil) }

      before(:each) { post :create, :event => invalid_attributes }

      it "assigns @event with the new event"

      describe "renders the view events/new with the correct layout" do
        it { should render_template("mweb_events/events/new") }
      end

      it "sets the flash with an error message"
    end
  end

  describe "#edit" do
    let(:event) { FactoryGirl.create(:event) }
    let(:owner) { event.owner }
    before(:each) { sign_in(owner) }

    context "layout and view" do
      before(:each) { get :edit, :id => event.to_param }
      it { should render_template("mweb_events/events/edit") }
    end

    it "assigns @event with the event" do
      # should assign_to(:event).with(event)
    end
  end

  describe "#update" do
    let(:event) { FactoryGirl.create(:event) }
    let(:owner) { event.owner }
    before(:each) { sign_in(owner) }

    context "with valid attributes" do
      let(:attributes) { FactoryGirl.attributes_for(:event) }
      before(:each) { put :update, :id => event, :event => attributes }

      it "sets the correct attributes in the event"

      it "redirects to the event" do
        should redirect_to(event_path(event))
      end

      it "assigns @event with the event" do
        should assign_to(:event).with(event)
      end

      it "sets the flash with a success message" do
        should set_the_flash.to(I18n.t('mweb_events.event.updated'))
      end

    end

    context "with invalid attributes" do
      let(:invalid_attributes) { FactoryGirl.attributes_for(:event, :name => nil) }

      before(:each) { put :update, :id => event.to_param, :event => invalid_attributes }

      it "assigns @event with the event"

      describe "renders the view events/edit with the correct layout" do
        it { should render_template("mweb_events/events/edit") }
      end

      it "sets the flash with an error message"
    end
  end

  it "#destroy"

  describe "abilities", :abilities => true do
  end

end
