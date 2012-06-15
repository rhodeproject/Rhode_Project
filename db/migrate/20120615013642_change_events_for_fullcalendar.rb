class ChangeEventsForFullcalendar < ActiveRecord::Migration
  def up
    add_column :events, :title, :string
    add_column :events, :description, :text
    add_column :events, :starts_at, :datetime
    add_column :events, :ends_at, :datetime

    remove_column :events, :start_at
    remove_column :events, :end_at

  end

  def down
    remove_column :events, :title
    remove_column :events, :description
    remove_column :events, :starts_at
    remove_column :events, :ends_at

    add_column :events, :start_at, :datetime
    add_column :events, :end_at, :datetime
  end
end
