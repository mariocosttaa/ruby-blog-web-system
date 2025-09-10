class CreatePostComments < ActiveRecord::Migration[8.0]
  def change
    create_table :post_comments do |t|
      # relations PostId
      t.references :post, null: false, foreign_key: { to_table: :posts, on_delete: :cascade }
      t.string :name, null: false
      t.string :email, null: false
      t.string :comment, null: false
      t.timestamps

      # indexes
      add_index :posts, [ :id ], unique: false
    end
  end
end
