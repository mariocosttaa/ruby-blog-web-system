class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.string :tittle, null: false
      t.text :description, null: false
      t.string :image, null: true
      t.boolean :status, default: true
      t.timestamps
    end
  end
end
