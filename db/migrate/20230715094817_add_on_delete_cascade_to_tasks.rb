class AddOnDeleteCascadeToTasks < ActiveRecord::Migration[7.0]
  def change
    def change
      remove_foreign_key :tasks, :projects
      add_foreign_key :tasks, :projects, on_delete: :cascade
    end
  end
end
