class AddNotNullToUsersAndRemoveColumns < ActiveRecord::Migration[6.1]
  def change
    change_column_null :users, :name, false
    remove_column :users, :is_showprofile
    remove_column :users, :is_servicestop
  end
end
