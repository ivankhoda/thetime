class AddTasksToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :tasks, :string
  end
end
