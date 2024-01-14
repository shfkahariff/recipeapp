class AddCustomFieldToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :phoneno, :string
    add_column :users, :address, :string
    add_column :users, :position, :string
    add_column :users, :profile_pic, :string
  end
end
