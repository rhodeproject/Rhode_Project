class AddForumToUsers < ActiveRecord::Migration
  def change
    add_column :users, :forum, :boolean, default: false
  end
end
