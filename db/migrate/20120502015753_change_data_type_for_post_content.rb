class ChangeDataTypeForPostContent < ActiveRecord::Migration
  def up
    change_table :posts do |t|
      t.change :content, :text
    end
  end

  def down
    change_table :posts do |t|
      t.change :content, :string
    end
  end
end
