class UpdatePlaceNumToPlace < ActiveRecord::Migration[6.1]
  def change
    remove_index :place, :place_num if index_exists?(:place, :place_num)
  end
end
