class AddMonthToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :month, :integer
  end
end
