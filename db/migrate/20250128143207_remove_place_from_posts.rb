class RemovePlaceFromPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :place, :integer
  end
end
