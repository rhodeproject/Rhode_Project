class AddAnniversaryDate < ActiveRecord::Migration
  def up
    add_column :users, :anniversary, :datetime
  end

  def down
    remove_column :users, :anniversary
  end
end
