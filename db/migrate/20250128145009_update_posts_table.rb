class UpdatePostsTable < ActiveRecord::Migration[6.1]
  def change
    change_column_null :posts, :title, false
    change_column_null :posts, :body, false
    change_column_null :posts, :user_id, false
    change_column_null :posts, :night, false
    change_column_null :posts, :people, false
    change_column_null :posts, :travelmonth, false

    remove_column :posts, :is_release, :boolean
    remove_column :posts, :is_stoprelease, :boolean
    remove_column :posts, :season, :integer
  end
end
