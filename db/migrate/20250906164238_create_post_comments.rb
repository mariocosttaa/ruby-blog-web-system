class CreatePostComments < ActiveRecord::Migration[8.0]
  def change
    create_table :post_comments do |t|
      # relations PostId
      t.references :post, null: false, foreign_key: true
      t.string :name, null: false
      t.boolean :email, null: false
      t.string :description, null: false
      t.string :comment, null: false
      t.timestamps
    end
  end
end
