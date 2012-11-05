class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.integer :user_id
      t.integer :event_id
      t.string :state

      t.timestamps
    end
  end
end
