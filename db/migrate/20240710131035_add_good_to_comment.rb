class AddGoodToComment < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :good, :integer
  end
end
