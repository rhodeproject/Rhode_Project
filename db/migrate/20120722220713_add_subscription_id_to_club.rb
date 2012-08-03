class AddSubscriptionIdToClub < ActiveRecord::Migration
  def change
    add_column :clubs, :subscription_id, :int
  end
end
