
FactoryBot.define do
  factory :project do
    name { "Project 1" }
    association :user
  end
end
