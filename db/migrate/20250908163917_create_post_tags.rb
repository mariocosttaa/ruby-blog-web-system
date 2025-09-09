class CreatePostTags < ActiveRecord::Migration[8.0]
  def change
    create_table :post_tags do |t|
      t.references :post, null: false, foreign_key: { to_table: :posts, on_delete: :cascade }
      t.references :tag, null: false, foreign_key: { to_table: :tags, on_delete: :cascade }
      t.timestamps
    end
    add_index :post_tags, [ :post_id, :tag_id ], unique: true
  end
end
