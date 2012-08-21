class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string :age
      t.text :bio
      t.string :blog

      t.timestamps
    end
  end
end
