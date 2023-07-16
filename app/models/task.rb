class Task < ApplicationRecord
  belongs_to :project
  validates :name, presence: true, length: { minimum: 3 }, uniqueness: true
  validates :description, length: { minimum: 3 , maximum: 300 }

  def start_timer
    self.started_at = Time.zone.now
    self.timer_running = true
    self.save
  end

  def stop_timer
    self.timer_running = false
    update_total_time
  end

  private

  def update_total_time
      self.time = self.time + (Time.zone.now - self.started_at).to_i
      self.save
  end
end
