class AddNotNullToComments < ActiveRecord::Migration[6.1]
  def change
    change_column_null :comments, :comment, false
    change_column_null :comments, :post_id, false
  end
end
