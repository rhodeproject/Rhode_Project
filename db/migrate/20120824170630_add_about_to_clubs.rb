class AddAboutToClubs < ActiveRecord::Migration
  def up
    add_column :clubs, :about, :text
  end

  def down
    remove_column :clubs, :about
  end
end
