class ChangeDefaultGoodInPosts < ActiveRecord::Migration[6.1]
  def change
    change_column_default :posts, :good, 0
  end
end
