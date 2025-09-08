class CreatePostCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :post_categories do |t|
      t.string :name, null: false, unique: true
      t.string :slug, null: false, unique: true
      t.text :description, null: true
      t.boolean :status, default: true
      t.timestamps
    end
  end
end
