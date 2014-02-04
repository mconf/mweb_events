require 'spec_helper'

describe MwebEvents::ParticipantsController do

  routes { MwebEvents::Engine.routes }

  describe "#index" do
    let(:event) { FactoryGirl.create(:event) }

    context "layout and view" do
      before(:each) { get :index, :event_id => event.to_param }
      it { should render_template("mweb_events/participants/index") }
    end

    it "assigns @participants"
  end

  describe "#new" do
    let(:event) { FactoryGirl.create(:event) }

    context "layout and view" do
      before(:each) { get :new, :event_id => event.to_param }
      it { should render_template("mweb_events/participants/new") }
    end

    it "assigns @participant"
  end

  describe "#create" do
    let(:owner) { FactoryGirl.create(:owner) }
    let(:event) { FactoryGirl.create(:event) }

    context "creating with valid attributes" do
      before(:each) {
        sign_in(owner)

        expect {
          post :create, :event_id => event, :participant => FactoryGirl.attributes_for(:participant, :email => owner.email)
        }.to change(MwebEvents::Participant, :count).by(1)

      }

      it { redirect_to event_path(event) }

      it "sets the flash with a success message" do
        should set_the_flash.to(I18n.t('participant.created'))
      end

      it { MwebEvents::Participant.last.owner.should eql(owner) }
      it { MwebEvents::Participant.last.event.should eql(event) }

    end

    context "creating with invalid attributes" do
      before(:each) {
        sign_in(owner)

        expect {
          post :create, :event_id => event, :participant => FactoryGirl.attributes_for(:participant, :email => 'booboo')
        }.to change(MwebEvents::Participant, :count).by(0)
      }

      it { should render_template("mweb_events/participants/new") }

      pending "sets the flash with an error message"

    end

  end

  describe "#destroy" do
    let(:participant) { FactoryGirl.create(:participant) }
    let(:owner) { participant.owner }
    let(:event) { participant.event }
    let(:event_owner) { event.owner }

    context "when is the participant's owner" do
      before(:each) {
        sign_in(owner)

        expect {
          delete :destroy, :id => participant.to_param, :event_id => event.to_param
        }.to change(MwebEvents::Participant, :count).by(-1)

      }

      it { should redirect_to event_path(event) }

      it "sets the flash with a success message" do
        should set_the_flash.to(I18n.t('participant.destroyed'))
      end
    end

    context "when is the event's owner" do

      before(:each) {
        sign_in(event_owner)

        expect {
          delete :destroy, :id => participant.to_param, :event_id => event.to_param
        }.to change(MwebEvents::Participant, :count).by(-1)

      }

      it { should redirect_to event_participants_path(event) }

      it "sets the flash with a success message" do
        should set_the_flash.to(I18n.t('participant.destroyed'))
      end

    end

  end

  describe "abilities", :abilities => true do
  end

end
