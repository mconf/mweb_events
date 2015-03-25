require "spec_helper"

describe MwebEvents::EventsController do

  routes { MwebEvents::Engine.routes }

  describe "#index" do
    context "layout and view" do
      context 'with no events' do
        before { get :index }

        it { should redirect_to events_path(:show => 'all') }
        it { assigns(:events).with([]) }
      end

      context 'with no upcoming events' do
        before {
          t = Time.zone.now
          @events = [
            FactoryGirl.create(:event, :start_on => t - 3.day, :end_on => t - 1.day),
            FactoryGirl.create(:event, :start_on => t - 2.day, :end_on => t - 1.day),
            FactoryGirl.create(:event, :start_on => t - 1.day, :end_on => t - 1.hour)
          ]

          get :index
        }

        it { should redirect_to events_path(:show => 'all') }
        it { assigns(:events).with(@events) }
      end

      context 'with upcoming events' do
        before {
          t = Time.zone.now
          @events = [
            FactoryGirl.create(:event, :start_on => t - 3.day, :end_on => t - 1.day),
            FactoryGirl.create(:event, :start_on => t + 1.day, :end_on => t + 10.day),
          ]

          get :index
        }

        it { should render_template("mweb_events/events/index") }
        it { assigns(:events).with([@events[1]]) }
      end
    end

    context "if params[:show]" do
      let(:zone) { Time.zone.name }
      let(:now) { Time.zone.now }
      let(:e1) { FactoryGirl.create(:event, :time_zone => zone, :start_on => now - 3.hour, :end_on => now - 2.hour) }
      let(:e2) { FactoryGirl.create(:event, :time_zone => zone, :start_on => now - 2.hour, :end_on => now - 1.hour) }
      let(:e3) { FactoryGirl.create(:event, :time_zone => zone, :start_on => now - 2.hour, :end_on => now + 5.minute) }
      let(:e4) { FactoryGirl.create(:event, :time_zone => zone, :start_on => now - 1.hour, :end_on => now + 10.minute) }
      let(:e5) { FactoryGirl.create(:event, :time_zone => zone, :start_on => now + 1.hour, :end_on => now + 2.hour) }
      let(:e6) { FactoryGirl.create(:event, :time_zone => zone, :start_on => now + 2.hour, :end_on => now + 3.hour) }

      context "is 'past_events'" do
        before(:each) { get :index, :show => 'past_events' }

        it { assigns(:events).should eq([e2, e1]) }
      end

      context "is 'upcoming_events'" do
        before(:each) { get :index, :show => 'upcoming_events' }

        it { assigns(:events).should eq([e5, e6]) }
      end

      context "is not present acts like 'upcoming_events'" do
        before(:each) { get :index }

        it { assigns(:events).should eq([e5, e6]) }
      end

      context "is 'happening_now'" do
        before(:each) { get :index, :show => 'happening_now' }

        it { assigns(:events).should eq([e3, e4]) }
      end

      context "is 'all'" do
        before(:each) { get :index, :show => 'all' }

        it { assigns(:events).should eq([e6, e5, e4, e3, e2, e1]) }
      end
    end

    context "if params[:q] is present" do
      let(:e1) { FactoryGirl.create(:event, :name => 'Party Hard') }
      let(:e2) { FactoryGirl.create(:event, :name => 'Party Soft') }

      context "find all" do
        before(:each) { get :index, :q => 'Party' }

        it { assigns(:events).should include(e1, e2) }
      end

      context "find one" do
        before(:each) { get :index, :q => 'hard' }

        it { assigns(:events).should include(e1) }
      end

      context "find nothing" do
        before(:each) { get :index, :q => 'Stay home and rest' }

        it { assigns(:events).should eq([]) }
      end

      context "find nothing with empty query" do
        before(:each) { get :index, :q => '' }

        it { assigns(:events).should eq([]) }
      end

    end

  end

  describe "#index.atom" do
    it "returns an rss with all the events available"
  end

  describe "#show.atom" do
    it "returns an rss with all the updates in the event"
  end

  describe "#show" do
    let(:event) { FactoryGirl.create(:event) }
    before(:each) { get :show, :id => event.to_param }

    context "layout and view" do
      it { should render_template("mweb_events/events/show") }
    end

    it { assigns(:event).should eq(event) }
  end

  describe "#new" do
    let(:owner) { FactoryGirl.create(:owner) }
    before(:each) { get :new }

    context "layout and view" do
      it { should render_template("mweb_events/events/new") }
    end

    it { assigns(:event) }
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
        assigns(:event).should eq(MwebEvents::Event.last)
      end

      it "sets the flash with a success message" do
        should set_the_flash.to(I18n.t('mweb_events.event.created'))
      end

      it "sets the current user as the owner" do
        MwebEvents::Event.last.owner.should eq(owner)
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
    before(:each) {
      sign_in(owner)
      get :edit, :id => event.to_param
    }

    context "layout and view" do
      it { should render_template("mweb_events/events/edit") }
    end

    it "assigns @event with the event" do
      assigns(:event).should eq(event)
    end
  end

  describe "#update" do
    let(:event) { FactoryGirl.create(:event) }
    let(:owner) { event.owner }
    before(:each) { sign_in(owner) }

    context "with valid attributes" do
      let(:attributes) { FactoryGirl.attributes_for(:event) }
      before(:each) { put :update, :id => event, :event => attributes.merge(
        {:start_on_date => attributes[:start_on].strftime('%m/%d/%Y'),
         :start_on_time => attributes[:start_on].strftime('%H:%M')
        }
        ).except(:start_on, :end_on)
      }

      it "sets the correct attributes in the event"

      it "redirects to the event" do
        should redirect_to(event_path(event))
      end

      it "assigns @event with the event" do
        assigns(:event).should eq(event)
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
