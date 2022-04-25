class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.uuid :id
      t.string :task_name
      t.string :task_category
      t.string :task_ranges
      t.string :task_status
      t.integer :cost

      t.timestamps
    end
  end
end
