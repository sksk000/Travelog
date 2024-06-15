class AddIsShowprofileToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :is_showprofile, :boolean
  end
end
