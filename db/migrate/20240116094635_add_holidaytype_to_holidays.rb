class AddHolidaytypeToHolidays < ActiveRecord::Migration[7.0]
  def change
    add_column :holidays, :holidaytype, :string
  end
end
