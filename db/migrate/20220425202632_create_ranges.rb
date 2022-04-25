class CreateRanges < ActiveRecord::Migration[7.0]
  def change
    create_table :ranges do |t|
      t.uuid :id
      t.string :from
      t.string :to

      t.timestamps
    end
  end
end
