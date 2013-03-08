atom_feed :version => "2.0" do |feed|
  feed.title "events"
  feed.updated @events.maximum(:updated_at)
  @events.each do |event|
    feed.entry event do |entry|
      entry.title event.title
      entry.content event.description
      entry.summary event.starts_at
      entry.author do |author|
        author.name event.club.name
      end
    end
  end
end