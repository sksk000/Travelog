class CreatePostPrefectures < ActiveRecord::Migration[6.1]
  def change
    create_table :post_prefectures do |t|
      t.references :post, null: false, foreign_key: true
      t.integer :prefecture

      t.timestamps
    end
  end
end
