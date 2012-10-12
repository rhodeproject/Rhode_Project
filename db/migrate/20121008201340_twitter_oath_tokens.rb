class TwitterOathTokens < ActiveRecord::Migration
  def up
    add_column :clubs, :oath_token, :string
    add_column :clubs, :oath_token_secret, :string
  end

  def down
    remove_column :clubs, :oath_token
    remove_column :clubs, :oath_token_secret
  end
end
