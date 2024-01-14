class CreateHolidays < ActiveRecord::Migration[7.0]
  def change
    create_table :holidays do |t|
      t.string :type
      t.date :startholiday
      t.date :endholiday

      t.timestamps
    end
  end
end
