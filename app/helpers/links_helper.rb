module LinksHelper
  def fix_providers(links)
    links.each do |l|
      l.provider = naive_string_scraper(l.link)
      l.save
    end
  end

  # does it much more naively, gets host from url, doesnt work if uri doesnt have "http"
  def naive_string_scraper(string)
    if (is_file?(string) == true)
      return file_provider(string)
    else
      providers = provider_list()
      host = URI.parse(string).host
      if !host.nil?
        return providers[host.downcase]
      else
        return "none" # takes care of nil cases, fucking hashes are teh shit
      end
    end
  end
  
  def provider_list()
    providers = Hash.new
    websites=["behance", "blogger", "delicious", "designfloat", "deviantart", "digg", "facebook", "flickr", "lastfm", "linkedin", "livejournal", "megavideo", "myspace", "piano", "playstation", "reddit", "rss", "socialvibe", "spotify", "stumbleupon", "technorati", "tumblr", "twitpic", "twitter", "vimeo", "wordpress", "youtube"]
    websites.each do |link|
      providers[ link + ".com"] = link
    end
    return providers
  end
  
  def is_file?(string)
    filetypes = file_types
    filetypes.each do |type|
      if string.include?("." + type)
        return true
      end
    end
  end
  
  def file_provider(string)
    filetypes = file_types
    filetypes.each do |type|
      if string.include?("." + type)
        return type
      end
    end
  end

  def file_types
    return ["aac", "aiff", "avi", "bat", "cmd", "dll", "dmg", "doc", "docu", "gif", "htm", "inf", "ini", "jpg", "midi", "mov", "mp3", "mp4", "none", "ocx", "png", "ppt", "psp", "rar", "rtf", "sitx", "sys", "txt", "wav", "xls", "zip"]
  end
  
end
