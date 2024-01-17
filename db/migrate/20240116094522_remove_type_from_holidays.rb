class RemoveTypeFromHolidays < ActiveRecord::Migration[7.0]
  def change
    remove_column :holidays, :type, :string
  end
end
