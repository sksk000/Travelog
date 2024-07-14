class RemoveDefaultFromGoodInComments < ActiveRecord::Migration[6.1]
  def change
    change_column :comments, :good, :integer, default: nil
  end
end
