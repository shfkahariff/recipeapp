class AddLeaveBalanceIdToLeaves < ActiveRecord::Migration[7.0]
  def change
    add_column :leaves, :leave_balance_id, :integer
    add_index :leaves, :leave_balance_id
  end
end
