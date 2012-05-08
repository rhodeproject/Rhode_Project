class AddIndexToForumsUsers < ActiveRecord::Migration
  def change
    add_index :forums_users, :forum_id
    add_index :forums_users, :user_id
  end
end
