class CreatePostCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :post_categories do |t|
      t.references :post, null: false, foreign_key: { to_table: :posts, on_delete: :cascade }
      t.references :category, null: false, foreign_key: { to_table: :categories, on_delete: :cascade }
      t.timestamps

      t.index [ :post_id, :category_id ], unique: true
    end
  end
end
