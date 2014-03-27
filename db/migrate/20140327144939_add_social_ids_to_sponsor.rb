class AddSocialIdsToSponsor < ActiveRecord::Migration
  def change
    add_column :sponsors, :facebook_id, :string
    add_column :sponsors, :twitter_id, :string
  end
end
