class AddClubIdToUsers < ActiveRecord::Migration
  def change
    add_column  :users, :club_id, :int
  end
end
