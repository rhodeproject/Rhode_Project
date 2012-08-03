class AddActiveToClubs < ActiveRecord::Migration
  def up
    add_column :clubs, :active, :boolean
  end

  def down
    remove_column :clubs, :active
  end
end
