class AddLimitToEvent < ActiveRecord::Migration
  def up
    add_column :events, :limit, :integer
  end

  def down
    remove_column :events, :limit
  end
end
