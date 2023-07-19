FactoryBot.define do
  factory :task do
    name { "Task 1" }
    description { "Description 1" }
    project_id { 1 }
  end
end
