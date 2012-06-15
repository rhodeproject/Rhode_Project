class AddHeadingsAndMessagesToClubs < ActiveRecord::Migration
  def change

    add_column :clubs, :heading1, :string
    add_column :clubs, :heading2, :string
    add_column :clubs, :heading3, :string

    add_column :clubs, :message1, :text
    add_column :clubs, :message2, :text
    add_column :clubs, :message3, :text

  end
end
