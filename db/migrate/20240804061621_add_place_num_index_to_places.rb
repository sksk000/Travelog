class AddPlaceNumIndexToPlaces < ActiveRecord::Migration[6.1]
  def change
    add_column :places, :place_num, :integer
    add_index :places, :place_num, unique: true
  end
end
