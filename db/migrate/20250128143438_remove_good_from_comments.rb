class RemoveGoodFromComments < ActiveRecord::Migration[6.1]
  def change
    remove_column :comments, :good, :integer
  end
end
