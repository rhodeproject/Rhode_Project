class AddAdminToForum < ActiveRecord::Migration
  def change
    add_column :forums, :admin, :boolean
  end
end
