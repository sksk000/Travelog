class AddPrefectureAndTravelMonthToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :prefecture, :integer
    add_column :posts, :travelmonth, :integer
  end
end
