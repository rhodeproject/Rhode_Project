class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|
      t.string :content
      t.integer :club_id

      t.timestamps
    end
  end
end
