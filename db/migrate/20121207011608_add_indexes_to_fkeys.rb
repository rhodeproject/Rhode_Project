class AddIndexesToFkeys < ActiveRecord::Migration
  def change
    add_index :users, :club_id, :name => "users_club_idx"
    add_index :forums, :club_id, :name => "forums_club_idx"
    add_index :posts, :topic_id, :name => "posts_topic_idx"
    add_index :posts, :user_id, :name => "posts_user_idx"
    add_index :posts, :club_id, :name => "posts_club_idx"
    add_index :topics, :forum_id, :name => "topics_forum_idx"
    add_index :topics, :user_id, :name => "topics_user_idx"
    add_index :events, :club_id, :name => "events_club_idx"
    add_index :lists, :user_id, :name => "lists_user_idx"
    add_index :lists, :event_id, :name => "lists_event_idx"
    add_index :notices, :club_id, :name => "notices_club_idx"
    add_index :profiles, :user_id, :name => "profiles_user_idx"
    add_index :sponsors, :club_id, :name => "sponsors_club_idx"
  end

end
