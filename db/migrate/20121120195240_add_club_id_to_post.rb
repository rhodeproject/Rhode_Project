class AddClubIdToPost < ActiveRecord::Migration
  def up
    add_column :posts, :club_id, :integer
  end

  def down
    remove_column :posts, :club_id
  end
end
