class Task < ApplicationRecord
  belongs_to :project
  validates :name, presence: true, length: { minimum: 3 }
  validates :description, length: { minimum: 3 , maximum: 300}
end
