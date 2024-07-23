class AddSeasonAndPlaceAndNightAndPeopleToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :season, :integer
    add_column :posts, :place, :integer
    add_column :posts, :night, :integer
    add_column :posts, :people, :integer
  end
end
