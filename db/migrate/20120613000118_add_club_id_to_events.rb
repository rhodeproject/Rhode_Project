class AddClubIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :club_id, :int
  end
end
