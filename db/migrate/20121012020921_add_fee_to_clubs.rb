class AddFeeToClubs < ActiveRecord::Migration
  def up
    add_column :clubs, :fee, :integer
  end

  def down
    remove_column :clubs, :fee
  end
end
