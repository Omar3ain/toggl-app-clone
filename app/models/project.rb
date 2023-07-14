class Project < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, length: { minimum: 3 }
  attribute :time, :integer, default: 0
end
