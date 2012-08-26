class AddActiveToUsers < ActiveRecord::Migration
  def up
    add_column  :users, :active, :boolean, :default => false

    User.reset_column_information

    users = User.all
    users.each do |u|
      u.active = true
      u.save
    end
  end
end
