class ChangeDefaultForIsReleaceInPosts < ActiveRecord::Migration[6.1]
  def change
    change_column_default :posts, :is_release, false
  end
end
