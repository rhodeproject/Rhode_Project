class AddMessageToClub < ActiveRecord::Migration
  def change
    add_column :clubs, :welcome_message, :text
  end
end
