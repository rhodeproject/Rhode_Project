class AddFacebookTwitterIds < ActiveRecord::Migration
  def change
    add_column :clubs, :facebook_id, :string
    add_column :clubs, :twitter_id, :string
  end
end
