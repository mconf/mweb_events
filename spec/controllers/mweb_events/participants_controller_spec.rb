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
    let(:event) { FactoryGirl.create(:event) }
  end

  it "#destroy"

  describe "abilities", :abilities => true do
  end

end
