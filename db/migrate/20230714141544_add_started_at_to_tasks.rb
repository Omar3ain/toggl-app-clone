class AddStartedAtToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :started_at, :datetime
  end
end
