class AddGoodToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :good, :integer
  end
end
