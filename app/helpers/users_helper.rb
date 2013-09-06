module UsersHelper
  def gravatar_for(user, options = { :size => 70, :class_name => "gravatar" })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    if options[:class_name].nil?
      class_name = "gravatar"
    else
      class_name = options[:class_name]
    end
    gravatar_url = "https://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"

    image_tag(gravatar_url, :alt => user.name, :class => "#{class_name}")
  end

end
