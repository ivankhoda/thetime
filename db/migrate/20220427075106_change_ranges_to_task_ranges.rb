class ChangeRangesToTaskRanges < ActiveRecord::Migration[7.0]
  def change
    rename_table :ranges, :task_ranges
  end
end
