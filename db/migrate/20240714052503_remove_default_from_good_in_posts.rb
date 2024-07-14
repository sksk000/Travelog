class RemoveDefaultFromGoodInPosts < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :good, :integer, default: nil
  end
end
