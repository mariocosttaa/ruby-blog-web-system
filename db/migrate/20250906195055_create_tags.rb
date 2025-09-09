class CreateTags < ActiveRecord::Migration[8.0]
  def change
    create_table :tags do |t|
      t.string :name, null: false
      t.boolean :status, default: true
      t.timestamps

      t.index [ :name ], unique: true
    end
  end
end
