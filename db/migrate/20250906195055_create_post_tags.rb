class CreatePostTags < ActiveRecord::Migration[8.0]
  def change
    create_table :posts_tags do |t|
      t.string :name, null: false
      t.boolean :status, default: true
      t.timestamps
    end
  end
end
