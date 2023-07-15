class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks
  validates :name, presence: true, length: { minimum: 3 }, uniqueness: true
  attribute :time, :integer, default: 0
end
