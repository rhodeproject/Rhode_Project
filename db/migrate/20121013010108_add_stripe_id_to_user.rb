class AddStripeIdToUser < ActiveRecord::Migration
  def up
    add_column :users, :stripe_id, :string
  end

  def down
    remove_column :users, :stripe_id
  end
end
