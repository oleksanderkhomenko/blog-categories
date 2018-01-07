class AddColumnViewsToPosts < ActiveRecord::Migration[5.1]
  def change
  	add_column :posts, :views_count, :integer, default: 0
  	add_column :posts, :likes_count, :integer, default: 0
  end
end
