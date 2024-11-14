class RemovePrefectureFromPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :prefecture, :integer
  end
end
