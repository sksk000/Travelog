class AddNotNullToPostPrefectures < ActiveRecord::Migration[6.1]
  def change
    change_column_null :post_prefectures, :prefecture, false
  end
end
