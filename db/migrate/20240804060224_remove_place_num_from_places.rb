class RemovePlaceNumFromPlaces < ActiveRecord::Migration[6.1]
  def change
    remove_column :places, :place_num, :integer
  end
end
