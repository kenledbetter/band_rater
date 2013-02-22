module ApplicationHelper
  def avatar_url(user)
    puts default_url = "#{root_url}guest.png"
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=48&d=retro"
  end
end
