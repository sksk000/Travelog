class RemoveMonthFromPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :month, :integer
  end
end
