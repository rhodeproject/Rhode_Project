class RemoveClubIdFromSubscriptions < ActiveRecord::Migration
  def up
    remove_column :subscriptions, :club_id
  end

  def down
    add_column :subscription, :club_id, :integer
  end
end
