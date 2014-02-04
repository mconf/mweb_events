# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :participant, :class => MwebEvents::Participant do
    owner { |p| p.association(:owner) }
    event { |p| p.association(:event) }
    email { |p| p.owner.email }
  end
end
