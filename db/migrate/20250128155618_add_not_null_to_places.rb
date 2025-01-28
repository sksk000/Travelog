class AddNotNullToPlaces < ActiveRecord::Migration[6.1]
  def change
    change_column_null :places, :post_id, false
    change_column_null :places, :place_name, false
    change_column_null :places, :address, false
    change_column_null :places, :latitude, false
    change_column_null :places, :longitude, false
    change_column_null :places, :place_num, false
    change_column_null :places, :good, false
  end
end
