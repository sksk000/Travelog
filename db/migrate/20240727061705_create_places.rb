class CreatePlaces < ActiveRecord::Migration[6.1]
  def change
    create_table :places do |t|
      t.references :post, foreign_key: true
      t.string :place_name
      t.string :address
      t.float :latitude
      t.float :longitude
      t.integer :place_num
      t.timestamps
    end
  end
end
