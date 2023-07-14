class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :client
      t.references :user, null: false, foreign_key: true
      t.integer :total_time

      t.timestamps
    end
  end
end
