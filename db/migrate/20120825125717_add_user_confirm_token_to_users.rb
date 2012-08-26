class AddUserConfirmTokenToUsers < ActiveRecord::Migration
  def up
    add_column :users, :confirm_token, :string
  end

  def down
    remove_column :users, :confirm_token
  end
end
