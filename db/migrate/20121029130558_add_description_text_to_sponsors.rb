class AddDescriptionTextToSponsors < ActiveRecord::Migration
  def up
    add_column :sponsors, :description, :text
  end

  def down
    remove_column :sponsors, :description
  end
end
