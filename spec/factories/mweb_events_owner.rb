# Read about factories at https://github.com/thoughtbot/factory_girl

# Not a real class, but just stubbing what the engine expects from event owners
class OpenStruct

  def self.primary_key
    'id'
  end

  def self.base_class
    ActiveRecord::Base
  end

  def [](param)
    self.send(param.to_sym)
  end

  def []=(param, val)
    self.send("#{param}=".to_sym, val)
  end

end

FactoryGirl.define do
  factory :owner, :class => OpenStruct do
    sequence(:id) { |n| n }
    name { Faker::Name.name }
    email { Faker::Internet.email }
  end
end

