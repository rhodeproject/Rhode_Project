namespace :posts do
  desc "updating posts with proper club_id"
  task :update => :environment do
    #Get all posts
    posts = Post.all
    posts.each do |p|
      puts "updating post #{p.id}"
      p.update_attribute('club_id',get_club(p.topic_id)) unless p.topic_id.nil?
      puts "update complete"
    end
  end
end

def get_club(topic_id)
  #get the forum for the topic
  forum = Forum.find(Topic.find(topic_id).forum_id)
  forum.club_id
end

