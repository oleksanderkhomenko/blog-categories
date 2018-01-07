class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :text
      t.integer :user_id
      t.integer :category_id, null: true

      t.timestamps
    end
  end
end
