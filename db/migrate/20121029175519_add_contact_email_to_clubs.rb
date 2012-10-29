class AddContactEmailToClubs < ActiveRecord::Migration
  def up
    add_column :clubs, :contact_email, :string
  end

  def down
    remove_column :clubs, :contact_email
  end
end
