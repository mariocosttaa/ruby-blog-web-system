class CreateCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.text :description, null: true
      t.boolean :status, default: true
      t.timestamps
    end

    add_index :categories, :name, unique: true
    add_index :categories, :slug, unique: true
  end
end
