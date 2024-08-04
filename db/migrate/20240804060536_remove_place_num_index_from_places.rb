class RemovePlaceNumIndexFromPlaces < ActiveRecord::Migration[6.1]
  def change
    remove_index :places, name: "index_places_on_place_num"
  end
end
