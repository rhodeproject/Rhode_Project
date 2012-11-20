class AddTermsAndConditionsToClub < ActiveRecord::Migration
  def up
    add_column :clubs, :terms_and_conditions, :text
  end

  def down
    remove_column :clubs, :terms_and_conditions
  end
end
