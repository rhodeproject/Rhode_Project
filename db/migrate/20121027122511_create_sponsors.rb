class CreateSponsors < ActiveRecord::Migration
  def change
    create_table :sponsors do |t|
      t.integer :club_id
      t.string :name
      t.string :image_name
      t.string :url

      t.timestamps
    end
  end
end
