class CreateForumsUsers < ActiveRecord::Migration
  def up
    create_table :forums_users, :id => false do |t|
      t.integer :forum_id
      t.integer :user_id
    end
  end

  def down
    drop_table :forums_users
  end
end
