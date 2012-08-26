class AddEcontactToProfile < ActiveRecord::Migration
  def up
    add_column :profiles, :econtact_name, :string
    add_column :profiles, :econtact_number, :string
  end

  def down
    remove_column :profiles, :econtact_name
    remove_column :profiles, :econtact_number
  end
end
