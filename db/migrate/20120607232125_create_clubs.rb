class CreateClubs < ActiveRecord::Migration
  def change
    create_table :clubs do |t|
      t.string :name
      t.string :sub_domain

      t.timestamps
    end
  end
end
