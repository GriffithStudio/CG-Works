module ApplicationHelper
  
  require "uri"
  
  def render_tweet(tweet)
		rendered_tweet = tweet.text

		for hashtag in tweet.hashtags.to_s.split(",")
			rendered_tweet.sub!("#{hashtag}", link_to(hashtag,"http://twitter.com/search/#{URI.escape(hashtag)}",:target => :blank))
		end

		for mention in tweet.mentions.to_s.split(",")
			rendered_tweet.sub!(/@#{mention}/i, link_to("@#{mention}","http://twitter.com/#{mention}",:target => :blank))
		end

		for link in tweet.links.to_s.split(",") do
			rendered_tweet.sub!((YAML::load(link)['display']), link_to((YAML::load(link)['source']),(YAML::load(link)['source']),:target => :blank))
		end

		for media in tweet.media.to_s.split(",") do
			rendered_tweet.sub!((YAML::load(media)['display']), "")
		end

		return raw rendered_tweet
	end
	
	def escaped_for_urls(url)
	  #CGI::encode(url)
	  return URI.escape(url, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
	end
	
end
