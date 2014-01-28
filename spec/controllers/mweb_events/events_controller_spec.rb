require "spec_helper"

describe MwebEvents::EventsController do

  # describe "#index" do
  #   let(:space) { FactoryGirl.create(:space) }
  #   let(:user) { FactoryGirl.create(:superuser) }
  #   before(:each) { sign_in(user) }

  #   context "layout and view" do
  #     before(:each) { get :index, :space_id => space.to_param }
  #     it { should render_template("events/index") }
  #     it { should render_with_layout("spaces_show") }
  #   end

  #   it "assigns @space"
  #   it "assigns @events"
  #   it "assigns @current_events"

  #   context "if params[:show] == 'past_events'" do
  #     it "assigns @past_events"
  #   end
  #   context "if params[:show] == 'upcoming_events'" do
  #     it "assigns @upcoming_events"
  #   end
  #   context "if params[:show] not set or invalid" do
  #     it "assigns @last_past_events"
  #     it "assigns @first_upcoming_events"
  #   end
  # end

  # describe "#index.atom" do
  #   it "returns an rss with all the events in the space"
  # end

  # describe "#show" do
  #   let(:space) { FactoryGirl.create(:space) }
  #   let(:event) { FactoryGirl.create(:event, :space => space) }
  #   let(:user) { FactoryGirl.create(:superuser) }
  #   before(:each) { sign_in(user) }

  #   context "layout and view" do
  #     before(:each) { get :show, :space_id => space.to_param, :id => event.to_param }
  #     it { should render_template("events/show") }
  #     it { should render_with_layout("spaces_show") }
  #   end

  #   it "assigns @space"
  #   it "assigns @event"
  #   it "assigns @webconf_room"
  #   it "assigns @attendees with the users that confirmed attendance"
  #   it "assigns @not_attendees with the users that confirmed that will not attend"
  # end

  # describe "#new" do
  #   let(:space) { FactoryGirl.create(:space) }
  #   let(:user) { FactoryGirl.create(:superuser) }
  #   before(:each) { sign_in(user) }

  #   context "layout and view" do
  #     before(:each) { get :new, :space_id => space.to_param }
  #     it { should render_template("events/new") }
  #     it { should render_with_layout("spaces_show") }
  #   end

  #   it "assigns @space"
  #   it "assigns @event"
  #   it "assigns @webconf_room"
  # end

  # describe "#create" do
  #   let(:space) { FactoryGirl.create(:space) }
  #   let(:user) { FactoryGirl.create(:superuser) }
  #   before(:each) { sign_in(user) }

  #   context "with valid attributes" do
  #     let(:event) { FactoryGirl.build(:event) }

  #     before(:each) {
  #       expect {
  #         post :create, :space_id => space.to_param, :event => event.attributes
  #       }.to change(Event, :count).by(1)
  #     }

  #     describe "creates the new event with the correct attributes" do
  #       # TODO: for some reason the matcher is not found, maybe we just need to update rspec and other gems
  #       pending { Event.last.should have_same_attibutes_as(event) }
  #     end

  #     it "redirects to the new event" do
  #       should redirect_to(space_event_path(space, Event.last))
  #     end

  #     it "assigns @event with the new event" do
  #       should assign_to(:event).with(Event.last)
  #     end

  #     it "assigns @space with the new event's space" do
  #       should assign_to(:space).with(Event.last.space)
  #     end

  #     it "sets the flash with a success message" do
  #       should set_the_flash.to(I18n.t('event.created'))
  #     end

  #     it "sets the current user as the author" do
  #       Event.last.author.should eq(user)
  #     end

  #     it "sets the event's space correctly" do
  #       Event.last.space.should eq(space)
  #     end

  #     it "assigns @webconf_room"
  #     it "creates a new activity for the event created"
  #   end

  #   context "with invalid attributes" do
  #     let(:invalid_attributes) { FactoryGirl.attributes_for(:event, :name => nil) }

  #     before(:each) { post :create, :space_id => space.to_param, :event => invalid_attributes }

  #     it "assigns @event with the new event"

  #     describe "renders the view events/new with the correct layout" do
  #       it { should render_template("events/new") }
  #       it { should render_with_layout("spaces_show") }
  #     end

  #     it "sets the flash with an error message"
  #     it "assigns @webconf_room"
  #     it "does not create a new activity for the event that failed to be created"
  #   end
  # end

  # describe "#edit" do
  #   let(:space) { FactoryGirl.create(:space) }
  #   let(:event) { FactoryGirl.create(:event, :space => space) }
  #   let(:user) { FactoryGirl.create(:superuser) }
  #   before(:each) { sign_in(user) }

  #   context "layout and view" do
  #     before(:each) { get :edit, :space_id => space.to_param, :id => event.to_param }
  #     it { should render_template("events/edit") }
  #     it { should render_with_layout("spaces_show") }
  #   end

  #   it "assigns @space"
  #   it "assigns @event"
  #   it "assigns @webconf_room"
  # end

  # describe "#update" do
  #   let(:event) { FactoryGirl.create(:event) }
  #   # before(:each) { sign_in(user) }

  #   # context "with valid attributes" do
  #   #   let(:attributes) { FactoryGirl.attributes_for(:event) }

  #   #   before(:each) { put :update, :space_id => space.to_param, :id => event.to_param, :event => attributes }

  #   #   it "sets the correct attributes in the event"

  #   #   it "redirects to the event" do
  #   #     event.reload # because the event's id/permalink will change
  #   #     should redirect_to(space_event_path(space, event))
  #   #   end

  #   #   it "assigns @event with the event" do
  #   #     should assign_to(:event).with(event)
  #   #   end

  #   #   it "sets the flash with a success message" do
  #   #     should set_the_flash.to(I18n.t('event.updated'))
  #   #   end

  #   #   it "assigns @space with the event's space" do
  #   #     should assign_to(:space).with(event.space)
  #   #   end

  #   #   it "assigns @webconf_room"
  #   #   it "creates a new activity for the event updated"
  #   # end

  #   # context "with invalid attributes" do
  #   #   let(:invalid_attributes) { FactoryGirl.attributes_for(:event, :name => nil) }

  #   #   before(:each) { put :update, :space_id => space.to_param, :id => event.to_param, :event => invalid_attributes }

  #   #   it "assigns @event with the event"

  #   #   it "assigns @space with the event's space" do
  #   #     should assign_to(:space).with(event.space)
  #   #   end

  #   #   describe "renders the view events/edit with the correct layout" do
  #   #     it { should render_template("events/edit") }
  #   #     it { should render_with_layout("spaces_show") }
  #   #   end

  #   #   it "sets the flash with an error message"
  #   #   it "assigns @webconf_room"
  #   #   it "does not create a new activity for the event that failed to be updated"
  #   # end
  # end

  # it "#destroy"

  # describe "abilities", :abilities => true do
  #   render_views(false)

  #   let(:attrs) { FactoryGirl.attributes_for(:event) }
  #   let(:hash) { { :space_id => target.space.to_param } }
  #   let(:hash_with_id) { hash.merge!(:id => target.to_param) }
  #   let(:hash_with_attrs) { hash_with_id.merge!(:event => attrs) }
  # end

end
