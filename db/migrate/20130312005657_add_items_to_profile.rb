class AddItemsToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :name_first, :string
    add_column :profiles, :name_last, :string
    add_column :profiles, :shirt_size, :string
    add_column :profiles, :dob, :datetime
    add_column :profiles, :contact_number, :string
  end
end
