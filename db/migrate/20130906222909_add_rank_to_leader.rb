class AddRankToLeader < ActiveRecord::Migration
  def change
    add_column :leaders, :rank, :integer
  end
end
