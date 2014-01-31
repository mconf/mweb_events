# Read about factories at https://github.com/thoughtbot/factory_girl

# Not a real class, but just stubbing what the engine expects from event owners
FactoryGirl.define do
  factory :owner, :class => User do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    created_at { Time.now }
    updated_at { Time.now }
    password { Faker::Lorem.characters 20 }
    password_confirmation { |o| o.password }
  end
end

