class AddClubIdToTokens < ActiveRecord::Migration
  def change
    add_column :tokens, :club_id, :int
  end
end
