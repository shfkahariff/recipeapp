class RemoveStartDateAndEndDateFromLeaves < ActiveRecord::Migration[7.0]
  def change
    remove_column :leaves, :startDate, :string
    remove_column :leaves, :endDate, :string
  end
end
