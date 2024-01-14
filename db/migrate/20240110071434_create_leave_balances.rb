class CreateLeaveBalances < ActiveRecord::Migration[7.0]
  def change
    create_table :leave_balances do |t|
      t.string :leavetype
      t.integer :balance

      t.timestamps
    end
  end
end
