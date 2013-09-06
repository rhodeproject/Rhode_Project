class CreateLeaders < ActiveRecord::Migration
  def change
    create_table :leaders do |t|
      t.string :title
      t.integer :user_id
      t.integer :club_id

      t.timestamps
    end
  end
end
