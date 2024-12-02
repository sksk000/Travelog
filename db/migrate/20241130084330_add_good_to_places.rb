class AddGoodToPlaces < ActiveRecord::Migration[6.1]
  def change
    add_column :places, :good, :integer
  end
end
