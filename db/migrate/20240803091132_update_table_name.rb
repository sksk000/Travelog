class UpdateTableName < ActiveRecord::Migration[6.1]
  def change
    add_column :places, :comment, :string
    remove_column :posts, :comment, :string
  end
end
