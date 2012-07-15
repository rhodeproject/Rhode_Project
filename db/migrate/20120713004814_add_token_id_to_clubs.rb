class AddTokenIdToClubs < ActiveRecord::Migration
  def change
    add_column :clubs, :token_id, :int
  end
end
