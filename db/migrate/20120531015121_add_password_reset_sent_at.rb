class AddPasswordResetSentAt < ActiveRecord::Migration
  def up
    add_column :users, :password_reset_sent_at, :datetime
  end

  def down
    drop_column :users, :password_reset_sent_at
  end
end
