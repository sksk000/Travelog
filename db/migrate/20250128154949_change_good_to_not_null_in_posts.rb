class ChangeGoodToNotNullInPosts < ActiveRecord::Migration[6.1]
  def change
    change_column_null :posts, :good, false
  end
end
