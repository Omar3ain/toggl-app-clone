class AddTimerRunningToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :timer_running, :boolean
  end
end
