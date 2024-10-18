class ChangeDefaultIsShowprofileInUsers < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :is_showprofile, from: nil, to: true
  end
end
