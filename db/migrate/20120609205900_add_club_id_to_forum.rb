class AddClubIdToForum < ActiveRecord::Migration
  def change
    add_column :forums, :club_id, :int
  end
end
