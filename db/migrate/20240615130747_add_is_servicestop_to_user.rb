class AddIsServicestopToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :is_servicestop, :boolean
  end
end
