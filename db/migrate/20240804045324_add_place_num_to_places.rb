class AddPlaceNumToPlaces < ActiveRecord::Migration[6.1]
  def change
    add_index :places, :place_num
  end
end
