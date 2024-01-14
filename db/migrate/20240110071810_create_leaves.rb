class CreateLeaves < ActiveRecord::Migration[7.0]
  def change
    create_table :leaves do |t|
      t.string :startDate
      t.string :endDate
      t.string :duration
      t.string :status
      t.string :notes
      t.string :attachment
      t.string :name
      t.string :comment

      t.timestamps
    end
  end
end
