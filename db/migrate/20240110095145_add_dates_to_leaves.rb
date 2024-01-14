class AddDatesToLeaves < ActiveRecord::Migration[7.0]
  def change
    add_column :leaves, :startDate, :date
    add_column :leaves, :endDate, :date
  end
end
