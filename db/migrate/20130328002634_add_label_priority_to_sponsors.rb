class AddLabelPriorityToSponsors < ActiveRecord::Migration
  def change
    add_column :sponsors, :label, :string
    add_column :sponsors, :priority, :integer
  end
end
