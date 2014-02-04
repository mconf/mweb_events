# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :participant, :class => MwebEvents::Participant do
    owner { |p| p.association(:owner) }
    event { |p| p.association(:event) }
    email nil

    after(:create) { |p| p.email = p.owner.email; p.save }
  end
end
