atom_feed :version => "2.0" do |feed|
  feed.title "sponsors"
  feed.updated @sponsors.maximum(:updated_at)
  @sponsors.each do |sponsor|
    feed.entry sponsor do |entry|
      entry.title sponsor.name
      entry.content sponsor.description
      entry.summary sponsor.url #the url for the link
      entry.author do |author|
        author.name sponsor.image_name #the image path
      end
    end
  end
end