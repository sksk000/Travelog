class ChangeDefaultGoodInComments < ActiveRecord::Migration[6.1]
  def change
    change_column_default :comments, :good, 0
  end
end
