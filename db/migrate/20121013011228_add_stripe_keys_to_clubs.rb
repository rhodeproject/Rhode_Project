class AddStripeKeysToClubs < ActiveRecord::Migration
  def up
    add_column :clubs, :stripe_publishable_key, :string
    add_column :clubs, :stripe_api_key, :string
  end

  def down
    remove_column :clubs, :stripe_publishable_key
    remove_column :clubs, :stripe_api_key
  end
end
