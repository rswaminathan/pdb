class LinksController < ApplicationController
  def create
  end


  def string_scraper(string)
    supported_sites = ["facebook.com","twitter.com","linkedin.com"]
    list = string.split(' ')
    return_hash = {}
    list.each do |link|
      c=nil
      supported_sites.each do |i|
        if link.includes?(i)
          return_hash[i] = link
          return_hash["other"].pop if c
          break
        elsif !return_hash["other"][-1]==(link)
          c=1
          return_hash["other"].push(link)
        end
      end
      return return_hash
    end
  end
end

