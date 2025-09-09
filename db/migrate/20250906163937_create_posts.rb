  class CreatePosts < ActiveRecord::Migration[8.0]
    def change
      create_table :posts do |t|
        t.references :user, foreign_key: { to_table: :users, on_delete: :cascade }
        t.string :title, null: false
        t.string :slug, null: false
        t.text :description, null: false
        t.string :image, null: true
        t.boolean :status, default: true
        t.timestamps
      end
      add_index :posts, :title, unique: true
      add_index :posts, :slug, unique: true
    end
  end
