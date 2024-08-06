class RemoveUniqueIndexFromPlaces < ActiveRecord::Migration[6.1]
  def change
    remove_index :places, :place_num if index_exists?(:places, :place_num, unique: true)
  end
end
