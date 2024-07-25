class ChangeIsReleaseToPost < ActiveRecord::Migration[6.1]
  def change
    change_column_default  :posts, :is_release, from: nil, to: true
  end
end
