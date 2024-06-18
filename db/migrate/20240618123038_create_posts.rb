class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :body
      t.boolean :is_release
      t.boolean :is_stoprelease
      t.references :user, foreign_key: true
      t.integer :spot, foreign_key: true
      t.timestamps
    end
  end
end
