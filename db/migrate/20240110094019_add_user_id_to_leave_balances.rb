class AddUserIdToLeaveBalances < ActiveRecord::Migration[7.0]
  def change
    add_column :leave_balances, :user_id, :integer
    add_index :leave_balances, :user_id
  end
end
