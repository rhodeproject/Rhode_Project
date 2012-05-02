class RemovePosterIdFromPosts < ActiveRecord::Migration
  def up
    remove_column :posts, :poster_id
  end

  def down
    add_column :posts, :poster_id, integer
  end
end
