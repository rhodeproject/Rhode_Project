class AddReferralCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :referral_count, :integer
  end
end
