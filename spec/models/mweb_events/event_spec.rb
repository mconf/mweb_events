require "spec_helper"

describe MwebEvents::Event do

  let(:event) { FactoryGirl.create(:event) }

  it "should not validate an event with wrong date range" do
  end

  it "creates a new instance given valid attributes" do
    FactoryGirl.build(:event).should be_valid
  end

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:permalink) }

  it { should have_many(:participants).dependent(:destroy) }

  it "#set_author_as_organizer"
  it "sets the author as organizer when the event is saved"
  it "doesn't set the author as organizer twice when the event is saved"
  it "doesn't set the author as organizer if there's no author set"

  describe ".within" do
    let(:today) { Time.now }

    before(:each) do
      e1 = FactoryGirl.create(:event, :start_on => today + 1.day, :end_on => today + 3.day)
      e2 = FactoryGirl.create(:event, :start_on => today, :end_on => today + 2.day)
    end

    it { Event.within(today, today + 2.day).should_not be_empty }
    it { Event.within(today + 1.day, today + 2.day).should_not be_empty }
    it { Event.within(today + 4.day, today + 5.day).should be_empty }
  end

  describe "abilities", :abilities => true do
    subject { ability }
    let(:ability) { Abilities.ability_for(user) }
    let(:target) { FactoryGirl.create(:event, :owner => FactoryGirl(:user)) }

    context "when is the event creator" do
      let(:user) { target.owner }
      it { should_not be_able_to_do_anything_to(target).except([:read, :edit, :update, :destroy]) }
    end

  end

end
